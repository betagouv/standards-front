# frozen_string_literal: true

require "rails_helper"

describe Evaluation::Question do
  let(:standards) do
    YAML.safe_load <<~YAML
          - id: question-1
            title: lovely test question
            category: test
            description: foobar
            criteria:
            - label: one
            - label: two
      YAML
  end

  let(:data) { standards.first }

  subject(:question) { described_class.new(data) }

  it { is_expected.to be_valid }

  it "deserializes critera into Criterion objects" do
    expect(question.criteria.first).to be_a Evaluation::Criterion
  end

  describe "complete?" do
    context "when all the critera answers are done" do
      before do
        question.criteria.each do |criteria|
          allow(criteria).to receive(:done?).and_return true
        end
      end

      it { is_expected.to be_complete }
    end

    context "when some criteria is unanswered" do
      before { allow(question.criteria.sample).to receive(:done?).and_return true }

      it { is_expected.to_not be_complete }
    end
  end
end
