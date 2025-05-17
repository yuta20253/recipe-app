# frozen_string_literal: true

class CreateRecipeIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :recipe_ingredients do |t|
      t.belongs_to :recipe, foreign_key: true, null: false
      t.belongs_to :ingredient, foreign_key: true, null: false
      t.string :quantity

      t.timestamps
    end

    # 同じレシピに同じ食材を2回登録できないようにする
    add_index :recipe_ingredients, %i[recipe_id ingredient_id], unique: true
  end
end
