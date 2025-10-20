# Standards de beta.gouv.rf : présentation et auto-évaluation

Cette application permet aux équipes de la communauté Beta de prendre
connaissance et d'évaluer leur produits selon les [standards de
beta.gouv.fr](https://github.com/betagouv/standards).

![Capture d’écran 2025-04-26 à 11 41 00](https://github.com/user-attachments/assets/f0c33e98-1272-43c2-82ca-8ddbd163ba2e)

## Fonctionnement

### 1. Standards

Les standards sont importés depuis le repo des [standards de
beta.gouv.fr](https://github.com/betagouv/standards) grâce à l'[export
YAML](https://github.com/betagouv/standards/releases) des questions.

### 2. Identification des équipes

L'application utilise ProConnect pour identifier les équipes, puis
utilise la base de données de l'[Espace-Membre de
Beta](https://espace-membre.incubateur.net/) pour récupérer leurs
startups actives.

Si une startup n'apparaît pas, le membre doit corriger sa fiche sur
l'Espace-Membre.

Dans l'environnement de test, se réferrer à [la documentation de
ProConnect sur les identifiants de test](https://partenaires.proconnect.gouv.fr/docs/fournisseur-service/identifiants-fi-test).

### 3. Évaluation d'un produit

L'évaluation est composé de questions groupées en catégories, avec des
critères binaires (oui/non). Elle est stockée en JSON, sans schéma,
sous la même forme que les standards mais en rajoutant une propriété
`answer` à chaque critère :

```yaml
# avant
- id: open-source
  title: le produit est open-source
  criteria:
  - label: votre code est disponible

# après
- id: open-source
  title: le produit est open-source
  criteria:
  - label: votre code est disponible
    answer: yes
```

Pour l'instant seules des réponses binaires sont envisagées, mais on
peut imaginer `n/a` et autres dans un futur proche.

### 4. Exposition de la données

Les évaluations sont disponibles sur deux terminaisons d'API :

#### `/api/evaluation/?startup_id=<ghid>`

Retourne l'évaluation complète de la startup.

`ghid` est l'identifiant GitHub de votre startup, c'est à dire [un
identifiant parmi ces fichiers sans l'extension
`.md`](https://github.com/betagouv/beta.gouv.fr/tree/master/content/_startups).

#### `/api/evaluation/summary?startup_id=<ghid>`

Retourne un sommaire de l'évaluation composé du pourcentage de
complétion par catégorie. Ce nombre indique le pourcentage de critères
dont la réponse est "oui" ou "non applicable".

```json
{
  "accessibilité": 42.0,
  "qualité-logicielle": 19.3
}
```

#### `/api/swagger_doc`

Une description Swagger est disonible sur cette terminaison.

## Développement

L'application contient le repo des standards à travers un submodule
git. Vous devez donc cloner aussi le sous-repo :

```sh
git submodule update --init --recursive
```

Une fois les standards importés, vous pouvez démarrer l'application
avec Docker :

```sh
make up
```

Consultez le [docker-compose.yml](./docker-compose.yml) et le
[Makefile](./Makefile) pour mieux connaître l'architecture du projet
et les commandes utiles. L'application suit les conventions
Rails.

### Développement d'un standard au sein de l'application

Pour faciliter le développement d'un standard au sein même de
l'application vous pouvez démarrer Guard, une librairie qui effectue
des actions en fonction des changements effectués :

```sh
# une fois l'application lancée
make up

# dans un autre terminal, lancez Guard
make guard
```

Guard est configuré pour vous permettre de faire de l'édition
instantanée d'un standard :

1. si un fichier Markdown change dans `./standards/**/*.md`
2. les standards sont recompilés dans `./standards-beta-vXXX.yml`
1. la dernière évaluation en date est supprimée sur l'outil
   d'évaluation (celle que vous consultez)
1. en rechargeant la page, les nouveaux standards sont utilisés, avec
   vos modifications.
