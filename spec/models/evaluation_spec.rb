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
  end
end
