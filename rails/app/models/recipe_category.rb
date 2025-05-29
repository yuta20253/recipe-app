class RecipeCategory < ApplicationRecord
  has_many :children, class_name: "RecipeCategory", foreign_key: "parent_id", dependent: :nullify
  belongs_to :parent, class_name: "RecipeCategory", optional: true
  has_many :recipes
end
