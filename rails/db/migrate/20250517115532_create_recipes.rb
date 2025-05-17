# frozen_string_literal: true

class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.belongs_to :user, foreign_key: true, null: false
      t.string :title, null: false
      t.text :description
      t.text :instructions
      t.integer :cooking_time
      t.integer :total_time
      t.string :servings
      t.integer :difficulty, null: false

      t.timestamps
    end
  end
end
