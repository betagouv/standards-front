# frozen_string_literal: true

module BetaStandards
  attr_reader :standards

  class << self
    def standards
      YAML.safe_load_file(standards_yml_file, permitted_classes: [ Date ])
    end

    private

    # this was initially a single environment variable pointing at the
    # standards file but it got annoying swapping real standards and
    # test standards constantly, so use the right scope of choosing
    # based on `Rails.env`, like OmniAuth and friends. And don't shy
    # away from hardcoding the paths until a compelling reason not to
    # comes up.
    def standards_yml_file
      path =
        if Rails.env.test?
          "spec/fixtures/files/dev-standards.yml"
        else
          "config/standards-beta.yml"
        end

      Rails.root.join(path)
    end
  end
end
