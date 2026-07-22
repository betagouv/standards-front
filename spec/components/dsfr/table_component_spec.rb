# frozen_string_literal: true

require "rails_helper"

RSpec.describe Dsfr::TableComponent, type: :component do
  it "renders the caption" do
    expect(
      render_inline(
        described_class
          .new(caption: "Table component")
          .with_content("Hello, components!")
      )
        .css("caption")
        .text
        .strip
    ).to eq "Table component"
  end
end
