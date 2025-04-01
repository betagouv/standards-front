module EspaceMembre
  class User < Record
    self.primary_key = "uuid"

    DOMAINES = %w[
      Coaching
      Autre
      Produit
      Intraprenariat
      Data
      Déploiement
      Animation
      Design
      Développement
      Support
    ]

    has_many :missions
    has_many :startups, through: :missions

    has_many :active_missions, -> { active }, class_name: "EspaceMembre::Mission"
    has_many :active_startups, through: :active_missions, source: :startups

    validates :username, :fullname, :role, :domaine, presence: true
    validates :domaine, inclusion: { in: DOMAINES }
  end
end
