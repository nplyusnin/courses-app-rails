# frozen_string_literal: true

module Courses
  class PreviewComponent < ApplicationComponent
    option :course
    option :current_user

    renders_one :button
  end
end
