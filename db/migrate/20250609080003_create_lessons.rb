# frozen_string_literal: true

class CreateLessons < ActiveRecord::Migration[8.0]
  def change
    create_table :lessons do |t|
      t.references :course,   null: false, foreign_key: true
      t.string     :title,    null: false
      t.integer    :position, null: false, default: 0

      t.timestamps
    end

    add_index :lessons, %i[course_id title], unique: true
    add_index :lessons, %i[course_id position], unique: true
  end
end
