# frozen_string_literal: true

require "swagger_helper"

describe "User Courses API", type: :request do
  path "/api/v1/students/courses" do
    let!(:courses) { create_list(:course, 2) }
    let!(:student) { create(:student) }

    before do
      student.study_courses << courses
    end

    get "List of study courses" do
      tags "Study Courses List"
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
                 },
                 required: %w[id title preview_image]
               }

        run_test!
      end
    end
  end
end
