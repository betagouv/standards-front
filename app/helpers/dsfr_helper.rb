# frozen_string_literal: true

module DsfrHelper
  class BreadcrumbBuilder < BreadcrumbsOnRails::Breadcrumbs::Builder
    def render
      # rubocop:disable Rails/HelperInstanceVariable
      @context.dsfr_breadcrumbs do |component|
        return "" if @elements.one? or @elements.empty?

        *links, last = @elements

        links.map do |element|
          component.with_breadcrumb(href: element.path, label: element.name)
        end

        component.with_breadcrumb(label: last.name) unless last.nil?
      end
      # rubocop:enable Rails/HelperInstanceVariable
    end
  end
end
