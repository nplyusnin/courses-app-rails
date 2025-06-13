# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"

  devise_for :users

  namespace :api do
    namespace :v1 do
      namespace :users do
        devise_scope :user do
          post "sign_in", to: "sessions#create"
          delete "/", to: "sessions#destroy"
          post "sign_up", to: "registrations#create"
        end
      end

      resources :courses, only: %i[index show], format: :json
    end
  end

  namespace :teacher do
    resources :courses, shallow: true do
      resources :lessons
    end
  end

  resources :courses, only: %i[index show] do
    resources :lessons, only: %i[index show] do
      member do
        post "done", to: "lessons#done", as: :done
      end
    end

    member do
      post "enroll", to: "courses#enroll", as: :enroll
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root "my_courses#index"
end
