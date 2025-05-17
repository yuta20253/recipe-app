# frozen_string_literal: true

class AddFamilyNameAndGivenNameAndAgeAndGender < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :family_name, :string, null: false
    add_column :users, :given_name, :string, null: false
    add_column :users, :age, :integer, null: false
    add_column :users, :gender, :integer, default: 0, null: false
  end
end
