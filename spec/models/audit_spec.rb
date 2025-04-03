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

  describe ".latest" do
    xit "returns the most recent audit" do
      old_audit = FactoryBot.create(:audit, created_at: 2.days.ago)
      new_audit = FactoryBot.create(:audit, created_at: 1.day.ago)

      expect(Audit.latest).to eq(new_audit)
    end
  end

  describe "data storage" do
    it "can store and retrieve JSON data" do
      test_data = { "category" => "design", "score" => 4 }
      audit.update(data: test_data)

      expect(audit.reload.data).to eq(test_data)
    end
  end
end
