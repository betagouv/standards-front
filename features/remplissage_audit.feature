# language: fr

Fonctionnalité: Remplissage de l'audit
  Contexte:
    Sachant que je suis "Marie Curie" avec l'email "marie.curie@beta.gouv.fr"
    Et que je participe au produit "Louvre"
    Quand je me connecte
    Et que je clique sur "Commencer l'audit pour la startup Louvre"

  Scénario: Le taux de complétion total est affiché
    Quand la page contient "0/7 standards validés (0%)"

  Scénario: Le taux de complétion évolue correctement
    Quand je clique sur "Ingrédients"
    Et que je complète le standard "Au moins trois oeufs frais"
    Et que je complète le standard "Du beurre"
    Et que je retourne au sommaire de l'audit en cours
    Alors la page contient "2/7 standards validés"
