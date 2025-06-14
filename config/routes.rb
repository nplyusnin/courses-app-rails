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

      namespace :student do
        resources :courses, only: %i[index], format: :json do
          resources :lessons, only: %i[index show], format: :json do
            member do
              post "done", to: "lessons#done", as: :done
            end
          end
        end
      end

      resources :courses, only: %i[index show], format: :json
    end
  end

  namespace :admin do
    resources :users, except: %i[new create]
  end

  namespace :student do
    resources :courses, only: %i[index] do
      resources :lessons, only: %i[index show] do
        member do
          post "done", to: "lessons#done", as: :done
        end
      end
    end
  end

  namespace :teacher do
    resources :courses, shallow: true do
      resources :lessons
    end
  end

  resources :courses, only: %i[index show] do
    member do
      post "enroll", to: "courses#enroll", as: :enroll
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root "student/courses#index"
end
