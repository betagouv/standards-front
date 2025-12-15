# frozen_string_literal: true

require "rails_helper"

describe QuestionPresenter do
  subject(:presenter) { described_class.new(question) }

  let(:question) { Evaluation.from_latest_standards.questions.first }

  describe "completion_level" do
    subject { presenter.completion_level }

    context "when no criteria has been answered" do
      it { is_expected.to be_zero }
    end

    context "when some criteria has been answered" do
      before do
        question.criteria.first.answer = "yes"
      end

      it { is_expected.to eq 50.0 }
    end

    context "when all criteria have been answered" do
      before do
        question.criteria.each do |criterion|
          criterion.answer = "no"
        end
      end

      it { is_expected.to eq 100.0 }
    end
  end

  describe "conformity_level" do
    subject { presenter.conformity_level }

    context "when all criteria is answered no" do
      before do
        question.criteria.each { |c| c.answer = "no" }
      end

      it { is_expected.to be_zero }
    end

    context "when all criteria is answered yes or n/a" do
      before do
        question.criteria.each { |c| c.answer = "yes" }
      end

      it { is_expected.to eq 100.0 }
    end
  end
end
