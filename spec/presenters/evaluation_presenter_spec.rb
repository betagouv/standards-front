# frozen_string_literal: true

require "rails_helper"

describe EvaluationPresenter do
  subject(:presenter) { described_class.new(evaluation) }

  let(:evaluation) { Evaluation.from_latest_standards }
  let(:category) { "ingrédients" }
  let(:questions) { evaluation.standards_for(category) }

  describe "completion_level" do
    subject { presenter.completion_level(category: category) }

    context "when no criteria have been answered" do
      it { is_expected.to be_zero }
    end

    context "when some criteria have been answered" do
      before do
        questions.first.criteria.first.answer = "yes"

        evaluation.save
      end

      it { is_expected.not_to be_zero }
    end

    context "when all criteria have been answered" do
      before do
        evaluation.standards_for("ingrédients").each do |question|
          question.criteria.each do |criterion|
            criterion.answer = "no"
          end
        end
      end

      it { is_expected.to eq 100.0 }
    end
  end
end
