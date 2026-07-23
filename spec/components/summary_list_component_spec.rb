# frozen_string_literal: true

require "rails_helper"

RSpec.describe SummaryListComponent, type: :component do
  subject! do
    render_inline(
      described_class.new.tap do |c|
        c.with_definition(**args)
      end

    )
  end

  let(:term) { "Foo" }
  let(:definition) { "Bar" }
  let(:args) { { term: term, definition: definition } }

  it "renders correctly" do
    expect(rendered_content)
      .to have_tag('dl', with: { class: 'summary-list' })
  end

  it "renders a term" do
    expect(rendered_content).to have_tag('dt', "Foo")
  end

  it "renders a definition" do
    expect(rendered_content).to have_tag('dd', "Bar")
  end

  context "when the definition is blank" do
    let(:definition) { "" }

    it "renders a placeholder" do
      expect(rendered_content).to have_tag('dd', "–")
    end
  end
end
