# frozen_string_literal: true

class MyCoursesController < ApplicationController
  before_action :authenticate_user!

  def index; end
end
