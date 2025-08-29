# frozen_string_literal: true

require "rails_helper"

describe Evaluation::Criterion do
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

  context "when the answer value is 'no'" do
    before { criterion.answer = "no" }

    it { is_expected.not_to be_done }
    it { is_expected.to be_answered }
  end

  context "when the answer value is 'yes'" do
    before { criterion.answer = "yes" }

    it { is_expected.to be_done }
    it { is_expected.to be_answered }
  end

  context "when the answer value is 'na'" do
    before { criterion.answer = "na" }

    it { is_expected.to be_done }
    it { is_expected.to be_answered }
  end
end
