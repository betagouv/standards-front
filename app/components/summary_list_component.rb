# frozen_string_literal: true

class SummaryListComponent < ViewComponent::Base
  renders_many :definitions, "DefinitionComponent"

  class DefinitionComponent < ViewComponent::Base
    attr_reader :term, :definition

    def initialize(term:, definition:)
      @term = term
      @definition = definition
    end
  end
end
