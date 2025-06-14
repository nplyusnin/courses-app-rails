# frozen_string_literal: true

require "swagger_helper"

describe "User Courses API", type: :request do
  path "/api/v1/courses" do
    let!(:courses) { create_list(:course, 2) }
    let!(:student) { create(:student) }

    get "List of courses" do
      tags "Courses List"
      consumes "application/json"
      produces "application/json"

      parameter name: :Authorization, in: :header, type: :string

      response "200", "Ok" do
        let(:Authorization) do
          generate_bearer_token_for(student)
        end

        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   title: { type: :string },
                   preview_image: { type: :string, nullable: true }
                 }
               }

        run_test!
      end
    end
  end

  path "/api/v1/courses/{id}" do
    let!(:courses) { create_list(:course, 2) }
    let!(:student) { create(:student) }

    get "Course details" do
      tags "Course Details"
      consumes "application/json"
      produces "application/json"

      parameter name: :Authorization, in: :header, type: :string
      parameter name: :id, in: :path, type: :string

      response "200", "Ok" do
        let(:id) { courses.first.id }
        let(:Authorization) do
          generate_bearer_token_for(student)
        end

        schema type: :object,
               properties: {
                 id: { type: :integer },
                 title: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string }
               }

        run_test!
      end
    end
  end
end
