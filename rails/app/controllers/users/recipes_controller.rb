# frozen_string_literal: true

module Users
  class RecipesController < ApplicationController
    def index
      @recipes = Recipe.includes(:ingredients)
    end
  end
end
