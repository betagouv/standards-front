# language: fr

Fonctionnalité: Remplissage de l'audit
  Contexte:
    Sachant que je suis "Marie Curie" avec l'email "marie.curie@beta.gouv.fr"
    Et que je participe au produit "Louvre"
    Quand je me connecte
    Et que je clique sur "Commencer l'audit pour la startup Louvre"

  Scénario: Le taux de complétion total est affiché
    Quand la page contient "standards validés (0%)"
    Et la page contient "Chaussures"
