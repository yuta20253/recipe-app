# frozen_string_literal: true

module Users
  class RecipesController < ApplicationController
    before_action :authenticate_user!
    before_action :find_recipe, only: %i[show edit update destroy]

    def index
      @recipes = Recipe.includes(:ingredients)
                       .search_recipe_name(params[:title])
                       .select_difficulty(params[:difficulty])
                       .registration_month(params[:created_at])
    end

    def new
      @recipe = Recipe.new
    end

    def create
      formatted_instructions =format_instructions(recipe_params[:instructions])
      @recipe = Recipe.new(recipe_params.merge(
        user_id: current_user.id,
        instructions: formatted_instructions
      ))
      @recipe.instructions = recipe_params[:instructions].reject(&:blank?).join("\n")
      if @recipe.save
        redirect_to %i[users recipes], notice: 'レシピを保存しました。'
      else
        logger.debug "保存失敗: #{@recipe.errors.full_messages}"
        render :new, status: :unprocessable_entity
      end
    rescue ArgumentError => e
      handle_invalid_difficulty(e, :new)
    end

    def show; end

    def edit; end

    def update
      formatted_instructions = format_instructions(recipe_params[:instructions])
      if @recipe.update(recipe_params.merge(instructions: formatted_instructions))
        redirect_to [:users, @recipe], notice: 'レシピの編集が完了しました。'
      else
        render :edit, status: :unprocessable_entity
      end
    rescue ArgumentError => e
      handle_invalid_difficulty(e, :edit)
    end

    def destroy
      @recipe.destroy
      redirect_to mypage_users_recipes_path
    end

    def mypage
      @recipes = current_user.recipes
                             .includes(:ingredients)
                             .search_recipe_name(params[:title])
                             .select_difficulty(params[:difficulty])
                             .registration_month(params[:created_at])
    end

    private

    def find_recipe
      @recipe = Recipe.find(params[:id])
    end

    def recipe_params
      params.require(:recipe).permit(
        :title,
        :description,
        :cooking_time,
        :total_time,
        :servings,
        :difficulty,
        instructions: [],
        ingredient_ids: []
      )
    end

    def format_instructions(raw_steps)
      raw_steps.reject(&:blank?).each_with_index.map { |step, i| "#{i + 1}. #{step}" }.join("\n")
    end

    def handle_invalid_difficulty(e, action)
      if e.message.include?('is not a valid difficulty')
        @recipe.errors.add(:difficulty, '難易度はeasy、medium、hardのいずれかを選択してください。')
        render action, status: :unprocessable_entity
      else
        raise e
      end
    end
  end
end
