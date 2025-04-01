# language: fr

Fonctionnalité: Page d'accueil
  Scénario: Quand je n'ai pas de produits on m'explique pourquoi
    Sachant que je suis "Marie Curie" avec l'email "marie.curie@beta.gouv.fr"
    Quand je me connecte
    Alors la page contient "Vous n'avez pas de produits actifs."

  Scénario: Quand je me connecte, je dois choisir un produit
    Sachant que je suis "Marie Curie" avec l'email "marie.curie@beta.gouv.fr"
    Et que je participe au produit "Louvre"
    Et que je participe au produit "Rivoli"
    Quand je me connecte
    Alors la page contient "Sélectionnez un de vos produits"
