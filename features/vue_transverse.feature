# language: fr

Fonctionnalité: Les produits des incubateurs peuvent être consultés
  Contexte:
    Sachant que je suis "Marie Curie" avec l'email "marie.curie@beta.gouv.fr"
    Et qu'un produit "Abbey Road" existe au sein de l'incubateur "Beatles"
    Et qu'un produit "Rubber Soul" existe au sein de l'incubateur "Beatles"
    Et qu'un produit "Sticky Fingers" existe au sein de l'incubateur "Rolling Stones"
    Quand je me connecte
    Et que je participe au produit "Abbey Road"
    Et que je démarre une évaluation pour "Abbey Road"
    Et je clique sur "Incubateurs"

  Scénario: Les produits actifs et le nombre d'évaluations sont affichés
    Et que je clique sur "Incubateurs"
    Alors le tableau "Tous les incubateurs" contient :
      | Nom            | Produits actifs | Évaluations |
      | Beatles        |               2 |           1 |
      | Rolling Stones |               1 |           0 |

  Scénario: Je peux choisir mon incubateur
    Et que je clique sur "Beatles"
    Alors le tableau "Beatles" contient :
      | Produit     | Phase           |
      | Abbey Road  | en construction |
      | Rubber Soul | en construction |

  Scénario: Les incubateurs sans produits actifs ne sont pas affichés
    Sachant qu'un produit "One" en phase "investigation" existe au sein de l'incubateur "The Kinks"
    Et qu'un produit "Two" en phase "transfere" existe au sein de l'incubateur "The Who"
    Et qu'un produit "Three" en phase "abandon" existe au sein de l'incubateur "Davie Bowie"
    Quand je rafraîchis la page
    Alors la page ne contient pas "The Who"
    Et la page ne contient pas "David Bowie"
    Et la page ne contient pas "The Kinks"

  Scénario: Je peux facilement retourner en arrière grâce au fil d'Ariane
    Quand je clique sur "Beatles"
    Alors le fil d'Ariane affiche "Tous les incubateurs > Beatles"
    Quand je clique sur "Abbey Road"
    Alors le fil d'Ariane affiche "Tous les incubateurs > Beatles > Évaluation de Abbey Road"
