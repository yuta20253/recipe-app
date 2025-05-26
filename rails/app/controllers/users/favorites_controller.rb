# frozen_string_literal: true

module Users
  class FavoritesController < ApplicationController
    before_action :authenticate_user!
    before_action :find_recipe

    def create
      current_user.favorites.find_or_create_by(recipe: @recipe)
      redirect_back_or_to users_recipes_path
    end

    def destroy
      favorite = current_user.favorites.find_by(recipe: @recipe)
      favorite&.destroy
      redirect_back_or_to users_recipes_path
    end

    private

    def find_recipe
      @recipe = Recipe.find(params[:recipe_id])
    end
  end
end
