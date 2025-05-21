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
      @recipe = Recipe.new(recipe_params)
      @recipe.user_id = current_user.id
      if @recipe.save
        redirect_to %i[users recipes], notice: 'レシピを保存しました。'
      else
        logger.debug "保存失敗: #{@recipe.errors.full_messages}"
        render 'new', status: :unprocessable_entity
      end
    rescue ArgumentError => e
      raise e unless e.message.include?('is not a valid difficulty')

      @recipe ||= Recipe.new
      @recipe.errors.add(:difficulty, '難易度はeasy、medium、hardのいずれかを選択してください。')
      render 'new', status: :unprocessable_entity
    end

    def show; end

    def edit; end

    def update
      if @recipe.update(recipe_params)
        redirect_to [:users, @recipe], notice: 'レシピの編集が完了しました。'
      else
        render 'edit', status: :unprocessable_entity
      end
    rescue ArgumentError => e
      raise e unless e.message.include?('is not a valid difficulty')

      @recipe ||= Recipe.new
      @recipe.errors.add(:difficulty, '難易度はeasy、medium、hardのいずれかを選択してください。')
      render 'new', status: :unprocessable_entity
    end

    def destroy
      if @recipe.destroy
        redirect_to mypage_users_recipes_path
      else
        render 'mypage'
      end
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
        :instructions,
        :cooking_time,
        :total_time,
        :servings,
        :difficulty,
        ingredient_ids: []
      )
    end
  end
end
