# frozen_string_literal: true

module AskCollection
  # defines a predicate on the object that will query a collection
  # designated by `to` and enumerate through it via the method
  # designated by `extent` to see if each element responds to the same
  # predicate, or another one specified with `via`. Exemples:
  #
  # class Book
  #   attr_reader :pages, default: []
  #
  #   # is the book read? i.e, have you read all the pages?
  #   asks :read?, to: :pages, extent: :all?
  #
  #   # by default, all? is used to query the underlying collection so
  #   # you could simplify the above:
  #   asks :read?, to: :pages
  #
  #   # is the book started? i.e, have you read a page?
  #   asks :started?, to: pages, extent: :some?, via: read?
  #
  #   # is the book annotated? i.e have you annotated any page?
  #   asks :annotated?, to: pages, extent: :any?
  def asks(question, to:, extent: :all?, via: nil)
    asking = via || question

    define_method(question) do
      collection = self.send(to)

      collection.send(extent) do |element|
        element.send(asking)
      end
    end
  end
end

# see you in court
module Enumerable
  alias :some? :any?
end
