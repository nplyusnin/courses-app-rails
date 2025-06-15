# frozen_string_literal: true

class ApplicationComponent < ViewComponent::Base
  extend Dry::Initializer
  include Pundit

  delegate :current_user, to: :helpers
end
