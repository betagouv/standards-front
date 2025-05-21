# language: fr

Fonctionnalité: Page d'accueil
  Scénario: Quand je n'ai pas de produits on m'explique pourquoi
    Sachant que je suis "Marie Curie" avec l'email "marie.curie@beta.gouv.fr"
    Quand je me connecte
    Alors la page contient "Vous n'avez pas de services actifs."

  Scénario: Quand je me connecte, je vois mes startups actives
    Sachant que je suis "Marie Curie" avec l'email "marie.curie@beta.gouv.fr"
    Et que je participe au produit "Louvre"
    Et que je participe au produit "Rivoli"
    Quand je me connecte
    Alors la page contient "Vos services"
    Et le titre de la page contient "Vos services"

  Scénario: Un menu rapide est disponible pour les utilisateurs connectés
    Sachant que je suis "Marie Curie" avec l'email "marie.curie@beta.gouv.fr"
    Quand je me connecte
    Alors l'en-tête contient "Vos services (Marie Curie)"
    Et l'en-tête contient "Déconnexion"
