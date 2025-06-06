class User < ApplicationRecord
  AVAILABLE_MANAGING_ROLES = %w[student teacher].freeze

  enum :role, { student: "student", teacher: "teacher", admin: "admin" }, validate: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
