class User < ApplicationRecord
  has_many :teaching_courses, class_name: "Course", foreign_key: "teacher_id", dependent: :destroy

  enum :role, { student: "student", teacher: "teacher", admin: "admin" }, validate: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
