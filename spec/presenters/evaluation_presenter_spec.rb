# frozen_string_literal: true

require "rails_helper"

describe EvaluationPresenter do
  subject(:presenter) { described_class.new(evaluation) }

  let(:evaluation) { Evaluation.from_latest_standards }
  let(:category) { "ingrédients" }
  let(:questions) { evaluation.standards_for(category) }

  describe "completion_level" do
    subject { presenter.completion_level }

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
        evaluation.questions.each do |question|
          question.criteria.each do |criterion|
            criterion.answer = "no"
          end
        end
      end

      it { is_expected.to eq 100.0 }
    end
  end

  describe "completion_stats" do
    subject(:stats) { presenter.completion_stats }

    it "returns an object keyed by category" do
      expect(stats.keys).to include category
    end

    it "returns the computed average of each category" do
      questions.each do |question|
        question.criteria.each { |c| c.answer = "yes" }
      end

      expect(stats["ingrédients"]).to eq 100
    end
  end

  describe "conformity_stats" do
    subject(:stats) { presenter.conformity_stats }

    it "returns an object keyed by category" do
      expect(stats.keys).to include category
    end

    it "returns the computed average of each category" do
      questions.first.criteria.each { |c| c.answer = "yes" }

      expect(stats["ingrédients"]).to eq 50
    end
  end
end
