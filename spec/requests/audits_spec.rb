require 'rails_helper'

RSpec.describe "Audits", type: :request do
  describe "PATCH /update" do
    let(:user) { FactoryBot.create(:user, :with_active_startup) }
    let(:startup) { user.active_startups.first }

    before { login_as(user.primary_email) }

    context "when updating an existing audit" do
      let!(:audit) do
        # Create an audit with sample questions and criteria
        audit = FactoryBot.create(:audit, startup_uuid: startup.uuid)

        # Add a sample question with criteria
        question = Audit::Question.new(
          id: "q1",
          title: "Test Question",
          category: "Test Category",
          description: "Test Description"
        )

        # Add criteria to the question
        criterion1 = Audit::Criterion.new(label: "Criterion 1")
        criterion2 = Audit::Criterion.new(label: "Criterion 2")
        question.instance_variable_set(:@criteria, [criterion1, criterion2])

        # Set the questions on the audit
        audit.questions = [question]
        audit.save!
        audit
      end

      fit "updates the audit criteria" do
        # Prepare the update parameters based on the structure in your controller
        update_params = {
          audit: {
            questions: {
              "q1" => {
                criteria: ["true", "false"] # Answers for the two criteria
              }
            }
          }
        }

        # Make the request
        patch "/startups/#{startup.ghid}/audit", params: update_params

        # Verify the response
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(edit_startup_audit_path(startup.ghid))

        # Reload the audit and verify the changes
        audit.reload
        updated_question = audit.questions.first
        expect(updated_question.criteria[0].answer).to eq("true")
        expect(updated_question.criteria[1].answer).to eq("false")
      end

      it "handles JSON requests" do
        update_params = {
          audit: {
            questions: [
              {
                id: "q1",
                criteria: ["true", "false"]
              }
            ]
          }
        }

        # Make a JSON request
        patch "/startups/#{startup.ghid}/audit", params: update_params, headers: { "Accept" => "application/json" }

        # Verify the JSON response
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to include("success" => true)
      end
    end
  end
end
