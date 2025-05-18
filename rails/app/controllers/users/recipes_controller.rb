# frozen_string_literal: true

module Users
  class RecipesController < ApplicationController
    before_action :authenticate_user!
    before_action :find_recipe, only: %i[show edit update destroy]

    def index
      @recipes = Recipe.includes(:ingredients)
    end

    def new
      @recipe = Recipe.new
    end

    def create; end

    def show; end

    def edit; end

    def update
      if @recipe.update(recipe_params)
        redirect_to [:users, @recipe]
      else
        render 'edit'
      end
    end

    def destroy; end

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
