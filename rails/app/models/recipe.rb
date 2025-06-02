# frozen_string_literal: true

class Recipe < ApplicationRecord
  include EnumHelp

  belongs_to :user
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_many :favorites
  has_many :favorited_by, through: :favorites, source: :user
  belongs_to :recipe_category, optional: false
  has_one_attached :image

  accepts_nested_attributes_for :ingredients

  enum difficulty: { easy: 0, medium: 1, hard: 2 }

  validates :title,
            presence: { message: 'タイトルは入力必須です。' },
            length: { maximum: 20, message: '20文字以内で入力してください。' }

  validates :difficulty,
            presence: { message: '難易度は必須です。' },
            inclusion: {
              in: difficulties.keys,
              message: '難易度はeasy、medium、hardのいずれかを選択してください。'
            }

  scope :search_recipe_name, lambda { |title|
    return all if title.blank?

    where('title LIKE ?', "%#{title}%")
  }

  scope :select_difficulty, lambda { |dif|
    return all if dif.blank?

    where(difficulty: dif)
  }

  scope :registration_month, lambda { |year_month|
    return all if year_month.blank?

    where("DATE_FORMAT(created_at, '%Y-%m') = ?", year_month)
  }
end
