# language: fr

Fonctionnalité: Mise à jour de l'évaluation
  Contexte:
    Sachant que je suis "Marie Curie" avec l'email "marie.curie@beta.gouv.fr"
    Et que je participe au produit "Louvre"
    Et que je me connecte
    Et que je clique sur "Commencer l'évaluation pour le service Louvre"
    Et que je clique sur "Ingrédients"
    Et que je complète le standard "Au moins trois oeufs frais"
    Et qu'une nouvelle version "46" des standards est disponible

  Scénario: Je suis prévenu qu'une nouvelle version est disponible
    Quand je retourne au sommaire de l'évaluation en cours
    Alors la page contient "La version 46 des standards est disponible"

  Scénario: Je peux inspecter la liste des changements
    Quand je retourne au sommaire de l'évaluation en cours
    Et que je clique sur "Voir les changements proposés"
    Alors la page contient "100% de vos réponses sont conservées"

  Scénario: Je peux mettre à jour mon évaluation
    Quand je retourne au sommaire de l'évaluation en cours
    Et que je clique sur "Voir les changements proposés"
    Et que je clique sur "Mettre à jour l'évaluation"
    Alors la page contient "L'évaluation a bien été mise à jour"
