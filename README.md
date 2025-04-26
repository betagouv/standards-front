# L'auto-audit de beta.gouv.fr

Cette application permet aux équipes de la communauté Beta de
s'auditer sur leur respect des [standards de
Beta](https://github.com/betagouv/standards).

![Capture d’écran 2025-04-26 à 11 38 53](https://github.com/user-attachments/assets/aa9a665e-a394-436f-8dd8-3944440db3d5)

## Fonctionnement

### 1. Standards

Les standards sont importés depuis le repo des [standards de
Beta](https://github.com/betagouv/standards) grâce à l'[export
YAML](https://github.com/betagouv/standards/releases) des questions.

### 2. Identification des équipes

L'application utilise ProConnect pour identifier les équipes, puis
utilise la base de données de l'[Espace-Membre de
Beta](https://espace-membre.incubateur.net/) pour récupérer leurs
startups actives.

Si une startup n'apparaît pas, le membre doit corriger sa fiche sur
l'Espace-Membre.

### 3. Remplissage de l'audit

L'audit est composé de questions groupées en catégories, avec des
critères binaires (oui/non). Il est stocké en JSON, sans schéma, sous
la même forme que les standards mais en rajoutant une propriété
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

Les résultats de l'audit seront mis à disposition très bientôt sur une
route d'API.

## Développement

L'application suit les conventions Rails. Pour démarrer :

```sh
make up
```

Consultez le [docker-compose.yml](./docker-compose.yml) et le
[Makefile](./Makefile) pour mieux connaître l'architecture du projet
et les commandes utiles.
