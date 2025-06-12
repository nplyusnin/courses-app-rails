# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  namespace :teacher do
    resources :courses, shallow: true do
      resources :lessons
    end
  end

  resources :courses, only: %i[index show] do
    resources :lessons, only: %i[index show]

    member do
      post "enroll", to: "courses#enroll", as: :enroll
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root "my_courses#index"
end
