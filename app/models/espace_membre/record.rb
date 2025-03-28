module EspaceMembre
  class Record < ActiveRecord::Base
    self.abstract_class = true

    db_name = Rails.env.test? ? :espace_membre_db_test : :espace_membre_db

    connects_to database: { writing: db_name, reading: db_name }
  end
end
