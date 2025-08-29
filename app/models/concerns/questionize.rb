# frozen_string_literal: true

module Questionize
  extend ActiveSupport::Concern

  class_methods do
    def questionize(attr)
      define_method "questionized_#{attr}" do
        questionize(self.send(attr))
      end
    end
  end

  included do
  end
end
