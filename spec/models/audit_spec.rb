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

  fdescribe "initialize_data" do
    subject(:audit) { Audit.new.initialize_with(standards) }

    let(:standards) do
      YAML.safe_load <<~YAML
          - id: question-1
            category: test
            description: foobar
            criteria:
            - label: one
            - label: two
      YAML
    end

    # it "copies the JSON over and adds answer to each criteria" do
    #   expected = YAML.safe_load(
    #     <<~YAML
    #     category:
    #       - id: question-1
    #         description: foobar
    #         criteria:
    #         - label: one
    #           answer:
    #         - label: two
    #           answer:
    #   YAML
    #   )

    #   expect(audit.data).to eq expected
    # end

    it "is deserialized with Audit::Question" do
      expect(audit.questions.first).to be_a Audit::Question
    end
  end
end
