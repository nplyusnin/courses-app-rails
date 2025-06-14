# frozen_string_literal: true

require "swagger_helper"

describe "User Lessons API", type: :request do
  let!(:course) { create(:course) }
  let!(:lessons) { create_list(:lesson, 2, course: course) }
  let(:lesson) { lessons.first }
  let!(:student) { create(:student) }

  path "/api/v1/students/courses/{course_id}/lessons" do
    get "List of study lessons" do
      tags "Study Lessons List"
      consumes "application/json"
      produces "application/json"

      parameter name: :course_id, in: :path, type: :string, description: "Course ID"
      parameter name: :Authorization, in: :header, type: :string

      response "200", "Ok" do
        let(:course_id) { course.id }
        let(:Authorization) do
          generate_bearer_token_for(student)
        end

        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   title: { type: :string }
                 },
                 required: %w[id title]
               }

        run_test!
      end
    end
  end

  path "/api/v1/students/courses/{course_id}/lessons/{id}" do
    get "Lesson details" do
      tags "Lesson Details"
      consumes "application/json"
      produces "application/json"

      parameter name: :course_id, in: :path, type: :string, description: "Course ID"
      parameter name: :id, in: :path, type: :string, description: "Lesson ID"
      parameter name: :Authorization, in: :header, type: :string

      response "200", "Ok" do
        let(:course_id) { course.id }
        let(:id) { lesson.id }
        let(:Authorization) do
          generate_bearer_token_for(student)
        end

        schema type: :object,
               properties: {
                 id: { type: :integer },
                 title: { type: :string },
                 content: { type: :string, nullable: true }
               },
               required: %w[id title content]

        run_test!
      end
    end
  end

  path "/api/v1/students/courses/{course_id}/lessons/{id}/done" do
    post "Mark lesson as done" do
      tags "Mark Lesson as Done"
      consumes "application/json"
      produces "application/json"

      parameter name: :course_id, in: :path, type: :string, description: "Course ID"
      parameter name: :id, in: :path, type: :string, description: "Lesson ID"
      parameter name: :Authorization, in: :header, type: :string

      response "200", "Ok" do
        let(:course_id) { course.id }
        let(:id) { lesson.id }
        let(:Authorization) do
          generate_bearer_token_for(student)
        end

        run_test!
      end
    end
  end
end
