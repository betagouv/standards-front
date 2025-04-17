# frozen_string_literal: true

require "rails_helper"

describe Audit::Criterion do
  subject(:criterion) { described_class.new(attributes) }

  let(:attributes) { { label: "foo" } }

  describe "when saved" do
    it "writes an answer" do
      expect(criterion.serializable_hash).to include("answer": nil, "label": "foo")
    end
  end
end
