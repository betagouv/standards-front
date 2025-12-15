# language: fr

Fonctionnalité: Remplissage de l'évaluation
  Contexte:
    Sachant que je suis "Marie Curie" avec l'email "marie.curie@beta.gouv.fr"
    Et que je participe au produit "Louvre"
    Quand je me connecte
    Et que je clique sur "Commencer l'évaluation pour le service Louvre"

  Scénario: Le taux de complétion total est affiché
    Alors la page contient "0/7 standards renseignés (0%)"

  Scénario: Je peux voir quelle version des standards je remplis
    Alors la page contient "Vous évaluez votre produit sur la version 42 des standards"

  Scénario: Le taux de complétion évolue correctement
    Sachant que je clique sur "Ingrédients"
    Et que je complète le standard "Au moins trois oeufs frais"
    Et que je complète le standard "Du beurre"
    Quand je retourne au sommaire de l'évaluation en cours
    Alors la page contient "2/7 standards renseignés"

  Scénario: Je ne suis pas obligé de répondre aux critères
    Sachant que je clique sur "Ingrédients"
    Et que je clique sur "Au moins trois oeufs frais"
    Quand je clique sur "Enregistrer"
    Alors la page contient "À compléter" pour le standard "Au moins trois oeufs frais"

  Scénario: Je peux répondre partiellement
    Sachant que je clique sur "Ingrédients"
    Et que je clique sur "Au moins trois oeufs frais"
    Et que je choisis "Oui" pour "Est-ce que les oeufs sont frais ?"
    Quand je clique sur "Enregistrer"
    Alors la page contient "À compléter" pour le standard "Au moins trois oeufs frais"

  Scénario: Lorsque je réponds "non" à toutes les critères
    Sachant que je clique sur "Ingrédients"
    Et que je clique sur "Au moins trois oeufs frais"
    Et que je choisis "Non" pour "Est-ce que les oeufs sont frais ?"
    Et que je choisis "Non" pour "Est-ce qu'au moins trois oeufs sont disponibles ?"
    Quand je clique sur "Enregistrer"
    Alors la page contient "Complété" pour le standard "Au moins trois oeufs frais"
