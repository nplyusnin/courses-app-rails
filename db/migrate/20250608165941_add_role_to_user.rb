# frozen_string_literal: true

class AddRoleToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :role, :string, default: "student", null: false
  end
end
