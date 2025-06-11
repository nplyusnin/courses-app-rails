# frozen_string_literal: true

class CreateStudentCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :student_courses do |t|
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.references :course,  null: false, foreign_key: true

      t.timestamps
    end

    add_index :student_courses, %i[student_id course_id], unique: true
  end
end
