require 'rails_helper'

RSpec.describe StatsHelper, type: :helper do
  let(:evaluation_one) { FactoryBot.create(:evaluation) }
  let(:evaluation_two) { FactoryBot.create(:evaluation) }

  let(:evaluations) { [ evaluation_one, evaluation_two ].map(&:presented) }

  describe "total_evaluations" do
    subject { helper.total_evaluations(evaluations) }

    it { is_expected.to eq 2 }
  end

  describe "total_completed_evaluations" do
    let(:evaluation_one) { FactoryBot.create(:evaluation, :complete) }

    subject { helper.total_completed_evaluations(evaluations) }

    it { is_expected.to eq 1 }
  end

  describe "average_completion_rate" do
    let(:evaluation_one) { FactoryBot.create(:evaluation, :complete) }

    subject { helper.average_completion_rate(evaluations) }

    it { is_expected.to eq 50.0 }
  end

  describe "average_completion_rate_per_category" do
    let(:evaluation_one) { FactoryBot.create(:evaluation, :complete) }

    subject { helper.average_completion_rate_per_category(evaluations) }

    it { is_expected.to include({ "dégustation" => 50.0 }) }
  end

  describe "average_completion_rate_per_category" do
    let(:evaluation_one) { FactoryBot.create(:evaluation, :complete) }
    let(:evaluation_two) { FactoryBot.create(:evaluation, :complete) }

    subject { helper.average_conformity_rate_per_category(evaluations) }

    it { is_expected.to include({ "dégustation" => 100.0 }) }
  end
end
