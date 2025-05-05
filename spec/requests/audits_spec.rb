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
        question.instance_variable_set(:@criteria, [ criterion1, criterion2 ])

        # Set the questions on the audit
        audit.questions = [ question ]
        audit.save!
        audit
      end

      it "updates the audit criteria" do
        # Prepare the update parameters based on the structure in your controller
        update_params = {
          audit: {
            audit_question: {
              id: "q1",
              criteria: { "0" => { answer: "1" }, "1" => { answer: "0" } }
            }
          }
        }

        # Make the request
        patch "/startups/#{startup.ghid}/audit", params: update_params

        # Verify the response
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(category_startup_audit_path(startup.ghid, "Test Category"))

        # Reload the audit and verify the changes
        audit.reload
        updated_question = audit.questions.first
        expect(updated_question.criteria[0].answer).to eq("1")
        expect(updated_question.criteria[1].answer).to eq("0")
      end
    end
  end
end
