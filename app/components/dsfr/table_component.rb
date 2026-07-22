# frozen_string_literal: true

class Dsfr::TableComponent < ViewComponent::Base
  renders_one :description
  renders_one :thead
  renders_one :tbody

  def initialize(caption:, small: false)
    @caption = caption
    @small = small
  end
end
