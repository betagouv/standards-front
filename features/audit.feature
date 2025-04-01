# language: fr

Fonctionnalité: Page d'accueil
  Contexte:
    Sachant que je suis "Marie Curie" avec l'email "marie.curie@beta.gouv.fr"
    Et que je participe au produit "Louvre"
    Et que je participe au produit "Rivoli"
    Quand je me connecte

  Scénario: Quand je choisis un produit qui n'a pas encore d'audit
    Sachant que je sélectionne "Rivoli" pour "Produit à auditer"
    Et que je clique sur "Sélectionner"
    Alors la page contient "Bienvenue dans l'audit de votre produit Rivoli"
