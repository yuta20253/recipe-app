# frozen_string_literal: true

class Ingredient < ActiveRecord::Migration[7.1]
  def change
    create_table :ingredients do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
