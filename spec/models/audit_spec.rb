require 'rails_helper'

RSpec.describe Evaluation, type: :model do
  subject(:evaluation) { FactoryBot.create(:evaluation) }

  describe "factory" do
    it "has a valid factory" do
      expect(evaluation).to be_valid
    end
  end

  describe "associations" do
    it "belongs to a startup" do
      expect(evaluation.startup).not_to be_nil
    end
  end

  describe "validations" do
    it "requires a startup_uuid" do
      evaluation = FactoryBot.build(:evaluation, startup_uuid: nil)
      expect(evaluation).not_to be_valid
    end
  end

  describe "initialize_data" do
    subject(:evaluation) { Evaluation.new.initialize_with(standards) }

    let(:standards) do
      YAML.safe_load <<~YAML
          - id: question-1
            category: test
            description: first test question
            criteria:
            - label: one
            - label: two
          - id: question-2
            category: other
            description: second test question
            criteria:
            - label: three
      YAML
    end

    it "is deserialized with Evaluation::Question" do
      expect(evaluation.questions.first).to be_a Evaluation::Question
    end

    describe "filtering categories" do
      before do
        allow(ENV)
          .to receive(:fetch)
                .with("BETA_STANDARDS_SELECTED_CATEGORIES", "")
                .and_return(selection)
      end

      context "when the BETA_STANDARDS_SELECTED_CATEGORIES env variable is set" do
        let(:selection) { "other,foobar, category" }

        it "only selects the category indicated" do
          expect(evaluation.questions.map(&:id)).to contain_exactly "question-2"
        end
      end

      context "when the BETA_STANDARDS_SELECTED_CATEGORIES env variable is not set" do
        let(:selection) { "" }

        it "doesn't filter the categories" do
          expect(evaluation.questions.map(&:id)).to contain_exactly "question-1", "question-2"
        end
      end
    end
  end
end
