module EspaceMembre
  class Record < ActiveRecord::Base
    self.abstract_class = true

    connects_to database: { writing: :espace_membre_db, reading: :espace_membre_db }
  end
end
