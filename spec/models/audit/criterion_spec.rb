# frozen_string_literal: true

require "rails_helper"

describe Audit::Criterion do
  subject(:criterion) { described_class.new(attributes) }

  let(:attributes) { { label: "foo" } }

  describe "when saved" do
    it "writes an answer" do
      expect(criterion.serializable_hash).to include({ "answer" => nil, "label" =>  "foo" })
    end
  end

  context "when then value is not present" do
    it { is_expected.not_to be_done }
    it { is_expected.not_to be_answered }
  end

  context "when the value is something else" do
    before { criterion.answer = "foo" }

    it { is_expected.not_to be_done }
    it { is_expected.to be_answered }
  end

  context "when the answer value is 1" do
    before { criterion.answer = "1" }

    it { is_expected.to be_done }
    it { is_expected.to be_answered }
  end
end
