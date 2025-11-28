# frozen_string_literal: true

require "rails_helper"

describe LanguageHelper, type: :helper do
  subject { helper.questionize(label) }

  let(:label) { "Le code produit est accessible" }

  it { is_expected.to eq "Est-ce que le code produit est accessible ?" }

  context "when the title start with a vowel" do
    let(:label) { "ubar" }

    it { is_expected.to eq "Est-ce qu'ubar ?" }
  end

  context "when the title starts with an accented vowel" do
    let(:label) { "éteindre les ordinateurs" }

    it { is_expected.to start_with "Est-ce qu'éteindre les ordinateurs ?" }
  end

  context "when the title ends with a dot" do
    let(:label) { "foobar." }

    it { is_expected.to end_with "bar ?" }
  end
end
