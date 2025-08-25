# language: fr

Fonctionnalité: Remplissage de l'audit
  Contexte:
    Sachant que je suis "Marie Curie" avec l'email "marie.curie@beta.gouv.fr"
    Et que je participe au produit "Louvre"
    Quand je me connecte
    Et que je clique sur "Commencer l'audit pour la startup Louvre"

  Scénario: Le taux de complétion total est affiché
    Alors la page contient "0/7 critères validés (0%)"

  Scénario: Le taux de complétion évolue correctement
    Sachant que je clique sur "Ingrédients"
    Et que je complète le standard "Au moins trois oeufs frais"
    Et que je complète le standard "Du beurre"
    Quand je retourne au sommaire de l'audit en cours
    Alors la page contient "2/7 critères validés"

  Scénario: Je ne suis pas obligé de répondre aux critères
    Sachant que je clique sur "Ingrédients"
    Et que je clique sur "Au moins trois oeufs frais"
    Quand je clique sur "Enregistrer"
    Alors la page contient "À faire" pour le standard "Au moins trois oeufs frais"

  Scénario: Je peux répondre partiellement
    Sachant que je clique sur "Ingrédients"
    Et que je clique sur "Au moins trois oeufs frais"
    Et que je choisis "Oui" pour "Est-ce que les oeufs sont frais ?"
    Quand je clique sur "Enregistrer"
    Alors la page contient "Partiellement" pour le standard "Au moins trois oeufs frais"

  Scénario: Lorsque j'ai déjà vu toutes les questions
    Sachant que je clique sur "Ingrédients"
    Et que je complète le standard "Du beurre"
    Quand je clique sur "Au moins trois oeufs frais"
    Alors la page ne contient pas de bouton "Enregistrer ma réponse et passer à la question suivante"

  Scénario: Lorsque je réponds "non" à toutes les critères
    Sachant que je clique sur "Ingrédients"
    Et que je clique sur "Au moins trois oeufs frais"
    Et que je choisis "Non" pour "Est-ce que les oeufs sont frais ?"
    Et que je choisis "Non" pour "Est-ce qu'au moins trois oeufs sont disponibles ?"
    Quand je clique sur "Enregistrer"
    Alors la page contient "Pas encore" pour le standard "Au moins trois oeufs frais"
