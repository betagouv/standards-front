require 'rails_helper'

RSpec.describe Audit, type: :model do
  subject(:audit) { FactoryBot.create(:audit) }

  describe "factory" do
    it "has a valid factory" do
      expect(audit).to be_valid
    end
  end

  describe "associations" do
    it "belongs to a startup" do
      expect(audit.startup).not_to be_nil
    end
  end

  describe "validations" do
    it "requires a startup_uuid" do
      audit = FactoryBot.build(:audit, startup_uuid: nil)
      expect(audit).not_to be_valid
    end
  end

  describe "initialize_data" do
    subject(:audit) { Audit.new.initialize_with(standards) }

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

    it "is deserialized with Audit::Question" do
      expect(audit.questions.first).to be_a Audit::Question
    end

    context "when the BETA_STANDARDS_SELECTED_CATEGORIES env variable is set" do
      before do
        allow(ENV).to receive(:fetch).with("BETA_STANDARDS_SELECTED_CATEGORIES").and_return "other,foobar, category"
      end

      it "only selects the category indicated" do
        expect(audit.questions.map(&:id)).to contain_exactly "question-2"
      end
    end

    context "when the BETA_STANDARDS_SELECTED_CATEGORIES env variable is not set" do
      before do
        allow(ENV).to receive(:fetch).with("BETA_STANDARDS_SELECTED_CATEGORIES").and_return ""
      end

      it "doesn't filter the categories" do
        expect(audit.questions.map(&:id)).to contain_exactly "question-1", "question-2"
      end
    end
  end
end
