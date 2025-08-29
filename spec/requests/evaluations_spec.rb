require 'rails_helper'

RSpec.describe "Evaluations", type: :request do
  describe "PATCH /update" do
    let(:user) { FactoryBot.create(:user, :with_active_startup) }
    let(:startup) { user.active_startups.first }

    before { login_as(user.primary_email) }

    context "when updating an existing evaluation" do
      let!(:evaluation) do
        # Create an evaluation with sample questions and criteria
        evaluation = FactoryBot.create(:evaluation, startup_uuid: startup.uuid)

        # Add a sample question with criteria
        question = Evaluation::Question.new(
          id: "q1",
          title: "Test Question",
          category: "Test Category",
          description: "Test Description"
        )

        # Add criteria to the question
        criterion1 = Evaluation::Criterion.new(label: "Criterion 1")
        criterion2 = Evaluation::Criterion.new(label: "Criterion 2")
        question.instance_variable_set(:@criteria, [ criterion1, criterion2 ])

        # Set the questions on the evaluation
        evaluation.questions = [ question ]
        evaluation.save!
        evaluation
      end

      it "updates the evaluation criteria" do
        # Prepare the update parameters based on the structure in your controller
        update_params = {
          evaluation: {
            evaluation_question: {
              id: "q1",
              criteria: { "0" => { answer: "1" }, "1" => { answer: "0" } }
            }
          }
        }

        # Make the request
        patch "/startups/#{startup.ghid}/evaluation", params: update_params

        # Verify the response
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(category_startup_evaluation_path(startup.ghid, "Test Category"))

        # Reload the evaluation and verify the changes
        evaluation.reload
        updated_question = evaluation.questions.first
        expect(updated_question.criteria[0].answer).to eq("1")
        expect(updated_question.criteria[1].answer).to eq("0")
      end

      context "when a criteria is missing" do
        it "updates anyway" do
          update_params = {
            evaluation: {
              evaluation_question: {
                id: "q1",
                criteria: { "1" => { answer: "0" } }
              }
            }
          }

          # Make the request
          patch "/startups/#{startup.ghid}/evaluation", params: update_params

          # Verify the response
          expect(response).to have_http_status(:redirect)
          expect(response).to redirect_to(category_startup_evaluation_path(startup.ghid, "Test Category"))

          # Reload the evaluation and verify the changes
          evaluation.reload
          updated_question = evaluation.questions.first
          expect(updated_question.criteria[0].answer).to eq(nil)
          expect(updated_question.criteria[1].answer).to eq("0")
        end
      end
    end
  end
end
