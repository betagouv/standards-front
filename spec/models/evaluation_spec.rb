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

  describe ".from_latest_standards" do
    subject(:evaluation) { Evaluation.from_latest_standards }

    it "is deserialized with Evaluation::Question" do
      expect(evaluation.questions.first).to be_a Evaluation::Question
    end

    it "stores the version" do
      expect(evaluation.version).to eq "42"
    end
  end
end
