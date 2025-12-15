# frozen_string_literal: true

require "rails_helper"

describe Evaluation::Criterion do
  subject(:criterion) { described_class.new(attributes) }

  let(:attributes) { { label: "foo" } }

  shared_examples_for "a criterion considered complete" do
    it { is_expected.not_to be_blank }
    it { is_expected.to be_complete }
  end

  shared_examples_for "a criterion considered valid" do
    it { is_expected.to be_done }
  end

  shared_examples_for "a criterion not considered valid" do
    it { is_expected.not_to be_done }
  end

  describe "when saved" do
    it "writes an answer" do
      expect(criterion.serializable_hash).to include({ "answer" => nil, "label" =>  "foo" })
    end
  end

  context "when then value is not present" do
    it { is_expected.to be_blank }

    it_behaves_like "a criterion not considered valid"
  end

  context "when the answer value is 'no'" do
    before { criterion.answer = "no" }

    it_behaves_like "a criterion considered complete"
    it_behaves_like "a criterion not considered valid"
  end

  described_class::CONSIDERED_PASS.each do |answer|
    context "when the answer value is '#{answer}'" do
      before { criterion.answer = answer }

      it_behaves_like "a criterion considered complete"
      it_behaves_like "a criterion considered valid"
    end
  end
end
