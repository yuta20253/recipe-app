# frozen_string_literal: true

class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

  accepts_nested_attributes_for :ingredients

  enum difficulty: { easy: 0, medium: 1, hard: 2 }

  scope :search_recipe_name, ->(title) {
    return all if title.blank?
    where('title LIKE ?', "%#{title}") }

  scope :select_difficulty, ->(dif) {
    return all if dif.blank?
    where(difficulty: dif) }

  scope :registration_month, ->(year_month) {
    return all if year_month.blank?
    where("DATE_FORMAT(created_at, '%Y-%m') = ?", year_month) }
end
