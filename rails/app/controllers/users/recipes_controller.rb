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

      @favorite_recipe_ids = current_user.favorites.where(recipe_id: @recipes.pluck(:id)).pluck(:recipe_id)
    end

    def new
      @form = Users::RecipeForm.new
    end

    def create
      @form = Users::RecipeForm.new(recipe_params.merge(user_id: current_user.id))
      if @form.save
        redirect_to %i[users recipes], notice: 'レシピを保存しました。'
      else
        render :new, status: :unprocessable_entity
      end
    rescue ArgumentError => e
      handle_invalid_difficulty(e, :new)
    end

    def show; end

    def edit
      @form = Users::RecipeForm.new(recipe: @recipe)
    end

    def update
      @form = Users::RecipeForm.new(recipe_params, recipe: @recipe)
      if @form.save
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
      params.require(:users_recipe_form).permit(
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
      raise e unless e.message.include?('is not a valid difficulty')

      @recipe.errors.add(:difficulty, '難易度はeasy、medium、hardのいずれかを選択してください。')
      render action, status: :unprocessable_entity
    end
  end
end
