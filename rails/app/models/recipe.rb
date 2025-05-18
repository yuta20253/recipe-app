# frozen_string_literal: true

class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

  accepts_nested_attributes_for :ingredients

  enum difficulty: { easy: 0, medium: 1, hard: 2 }
end
