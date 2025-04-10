# language: fr

Fonctionnalité: Page d'accueil
  Contexte:
    Sachant que je suis "Marie Curie" avec l'email "marie.curie@beta.gouv.fr"
    Et que je participe au produit "Louvre"
    Et que je participe au produit "Rivoli"
    Quand je me connecte

  Scénario: Quand mes produits n'ont pas encore d'audit
    Alors la page contient un lien "Commencer l'audit pour la startup Rivoli"
