class AddRecipeCategoryIdToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_reference :recipes, :recipe_category, null: false, foreign_key: true
  end
end
