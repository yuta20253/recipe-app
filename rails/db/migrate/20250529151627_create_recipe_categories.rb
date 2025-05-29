class CreateRecipeCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :recipe_categories do |t|
      t.string :name, null: false
      t.bigint :parent_id

      t.timestamps
    end
    add_foreign_key :recipe_categories, :recipe_categories, column: :parent_id
  end
end
