# frozen_string_literal: true

require "rails_helper"

describe EvaluationUpgrader do
  subject(:upgrader) { described_class.new(evaluation, new_standards) }

  let(:standards)     { { "standards" => FactoryBot.attributes_for_list(:question, 3), "version" => '42' } }
  let(:new_standards) { standards.deep_dup.merge!("version" => "46") }
  let(:evaluation)    { FactoryBot.create(:evaluation).initialize_with(standards) }

  before 'fill in all answers' do
    evaluation.categories.each do |category|
      evaluation.standards_for(category).each do |question|
        question.criteria.each do |crit|
          crit.answer = "yes"
        end
      end
    end

    evaluation.save!
  end

  context "when nothing has changed" do
    it "can tell whether the evaluation is outdated" do
      expect(upgrader.changes).to be_empty
    end

    it "returns 100% for the amount of criteria saved" do
      expect(upgrader.saved_criteria_percentage).to eq 100.0
    end
  end

  context "when a standard has been added" do
    let(:new_standard) { FactoryBot.build(:question).attributes }

    before do
      new_standards["standards"].push(new_standard)
    end

    it "makes the evaluation outdated" do
      expect(upgrader.changes).not_to be_empty
    end

    it "has the new standard in the added key" do
      expect(upgrader.changes[:added]).to contain_exactly(Evaluation::Question.new(new_standard))
    end

    it "has the right saved criteria percentage" do
      expect(upgrader.saved_criteria_percentage).to eq 100.0
    end
  end

  context "when a standard has been deleted" do
    let!(:first_question) { new_standards["standards"].delete_at(1) }

    it "makes the evaluated outdated" do
      expect(upgrader.changes).not_to be_empty
    end

    it "has the old standard in the deleted key" do
      expect(upgrader.changes[:deleted]).to contain_exactly(Evaluation::Question.new(first_question))
    end

    it "has the right saved criteria percentage" do
      expect(upgrader.saved_criteria_percentage).to eq 99.0
    end
  end

  context "when the criteria of a standard have changed" do
    before do
      new_standards["standards"].first[:criteria][0] = { label: "l'équipe va plutôt bien" }
    end

    it "indicates the change" do
      expect(upgrader.changes).not_to be_empty
    end

    it "has the right saved criteria percentage" do
      expect(upgrader.saved_criteria_percentage).to eq 99
    end

    it "applies the update correctly" do
      upgrader.apply!

      expect(evaluation.questions.first.criteria.first).to be_blank
      expect(evaluation.questions.second.criteria.first).to be_answered
    end
  end

  describe ".apply!" do
    it "upgrades the version" do
      expect { upgrader.apply! }
        .to change(evaluation.reload, :version)
        .from("42")
        .to("46")
    end
  end
end
