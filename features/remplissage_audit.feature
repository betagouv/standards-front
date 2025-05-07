# language: fr

Fonctionnalité: Remplissage de l'audit
  Contexte:
    Sachant que je suis "Marie Curie" avec l'email "marie.curie@beta.gouv.fr"
    Et que je participe au produit "Louvre"
    Quand je me connecte
    Et que je clique sur "Commencer l'audit pour la startup Louvre"

  Scénario: Le taux de complétion total est affiché
    Alors la page contient "0/7 standards validés (0%)"

  Scénario: Le taux de complétion évolue correctement
    Sachant que je clique sur "Ingrédients"
    Et que je complète le standard "Au moins trois oeufs frais"
    Et que je complète le standard "Du beurre"
    Quand je retourne au sommaire de l'audit en cours
    Alors la page contient "2/7 standards validés"

  Scénario: Je peux avancer directement à la question d'après
    Sachant que je clique sur "Ingrédients"
    Et que je clique sur "Au moins trois oeufs frais"
    Et que je coche toutes les cases
    Quand je clique sur "Enregistrer ma réponse et passer à la question suivante"
    Alors le titre de la page contient "Du beurre"

  Scénario: Je ne suis pas obligé de répondre aux critères
    Sachant que je clique sur "Ingrédients"
    Et que je clique sur "Au moins trois oeufs frais"
    Quand je clique sur "Enregistrer ma réponse et passer à la question suivante"
    Alors le titre de la page contient "Du beurre"

  Scénario: Lorsque j'ai déjà vu toutes les questions
    Sachant que je clique sur "Ingrédients"
    Et que je complète le standard "Du beurre"
    Quand je clique sur "Au moins trois oeufs frais"
    Alors la page ne contient pas de bouton "Enregistrer ma réponse et passer à la question suivante"
