# language: fr

Fonctionnalité: Page d'accueil
  Contexte:
    Sachant que je suis "Marie Curie" avec l'email "marie.curie@beta.gouv.fr"
    Et que je participe au produit "Louvre"
    Et que la fonctionnalité "question suivante" est activée
    Et que je me connecte
    Et que je clique sur "Commencer l'audit pour la startup Louvre"

  Scénario: Je peux avancer directement à la question d'après
    Sachant que je clique sur "Ingrédients"
    Et que je clique sur "Au moins trois oeufs frais"
    Et que je choisis "Oui" pour chaque critère
    Quand je clique sur "Enregistrer ma réponse et passer à la question suivante"
    Alors le titre de la page contient "Du beurre"
