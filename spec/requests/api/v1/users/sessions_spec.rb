# frozen_string_literal: true

require "swagger_helper"

describe "User Sessions API", type: :request do
  path "/api/v1/users/sign_in" do
    let(:registred_user) { create(:user) }

    post "Sign in a user" do
      tags "User Sessions"
      consumes "application/json"
      produces "application/json"

      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string, format: :email },
              password: { type: :string }
            },
            required: %w[email password]
          }
        }
      }

      response "201", "User signed in successfully" do
        let(:body) do
          {
            user: {
              email: registred_user.email,
              password: registred_user.password
            }
          }
        end

        schema type: :object,
               properties: {
                 user: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     email: { type: :string, format: :email },
                     created_at: { type: :string, format: :date_time },
                     updated_at: { type: :string, format: :date_time }
                   }
                 }
               }

        run_test!
      end

      response "401", "Invalid credentials" do
        let(:body) do
          {
            user: {
              email: registred_user.email,
              password: "wrong_password"
            }
          }
        end

        schema type: :object,
               properties: {
                 error: {
                   type: :string,
                   example: I18n.t("devise.failure.unauthenticated")
                 }
               }

        run_test!
      end
    end
  end

  path "/api/v1/users" do
    let!(:user) { create(:user) }

    delete "Sign out a user" do
      tags "User Sessions"
      consumes "application/json"
      produces "application/json"

      parameter name: :Authorization, in: :header, type: :string

      response "204", "Not content" do
        let(:Authorization) do
          generate_bearer_token_for(user)
        end

        run_test!
      end

      response "204", "Not content" do
        let(:Authorization) { nil }

        run_test!
      end
    end
  end
end
