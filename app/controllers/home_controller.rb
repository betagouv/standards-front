class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
  end

  def standards
    yaml_path = Rails.root.join('spec', 'fixtures', 'files', 'dev-standards.yml')
    @standards = YAML.load_file(yaml_path)
  end
end
