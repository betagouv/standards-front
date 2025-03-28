# language: fr

# Note : les IDEs et leurs plugins Cucumber sont censés pouvoir gérer
# l'internationalisation et donc les mots-clés en français aussi.

Fonctionnalité: Page d'accueil
  Scénario: La page d'accueil est établie
    Quand je me rends sur la page d'accueil
    Alors le titre de la page contient "Bienvenue - Bretelles"

  Scénario: Un bouton de connexion est disponible
    Quand je me rends sur la page d'accueil
    Alors la page contient un bouton "Connexion"
