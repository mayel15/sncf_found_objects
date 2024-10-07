# 🔎 SNCF - Objets Trouvés

| ![Alaaeddin ALMAJJO](https://avatars.githubusercontent.com/u/77294802?v=4) | ![Pape THIAM](https://avatars.githubusercontent.com/u/97792012?v=4) |
| :------------------------------------------------------------------------: | :-----------------------------------------------------------------: |
|                             Alaaeddin ALMAJJO                              |                             Pape THIAM                              |
|                                  22001993                                  |                              22009010                               |
|                  [@aladinMJ](https://github.com/aladinMJ)                  |               [@mayel15](https://github.com/mayel15)                |
|                         alaaeddin.almajjo@uphf.fr                          |                    papemayeldiagne.thiam@uphf.fr                    |

# 📱 Demo de l'application

![alt text](readme-images/found-objects-app-demo.gif)

# 🧰 Technos utilisées

<a href="https://dart.dev" target="_blank" rel="noreferrer"> <img src="./readme-images/dart.svg" alt="dart" width="100" height="100"/> </a> <a href="https://flutter.dev" target="_blank" rel="noreferrer"> <img src="./readme-images/flutter.svg" alt="flutter" width="100" height="100"/> </a>

# ➕ More

- [provider](https://pub.dev/packages/syncfusion_flutter_datepicker)
- [path_provider](https://pub.dev/packages/path_provider)
- [http](https://pub.dev/packages/http)
- [filter_list](https://pub.dev/packages/filter_list)

# 🧐 Description du projet et choix d'implémentation

## 📄 Description du projet

Ce projet consiste en la création d'une application mobile Flutter permettant aux voyageurs de consulter la liste des objets trouvés dans les trains. L'application exploite l'API de la SNCF dédiée aux objets trouvés pour fournir des informations en temps réel.

**Fonctionnalités principales** :

- **Consultation des objets trouvés** : Affichage des objets non encore restitués, avec la possibilité de les filtrer selon différents critères (gare d'origine, catégorie d'objet, plage de dates, rafraichir les filtres).
- **Suivi personnalisé** : Les utilisateurs peuvent voir les nouveaux objets trouvés depuis leur dernière connexion ou consultation.
- **Interface intuitive** : L'application offre une expérience fluide et accessible, facilitant la recherche d'objets perdus par les voyageurs.
- **Lien vers l'API SNCF utilisée** : [Objets trouvés SNCF](https://data.sncf.com/explore/dataset/objets-trouves-restitution/api/)

**Remarque** : Au sein de l'application, le boutton `refresh` reinitialise les filtres et mets à jour la dernière date de consultation comme étant le premier jour du mois en cours. Cependant, si le bouton n'est pas cliquée au cours de l'utilisation, la dernière date de consultation va correspondre à la date actuelle.

## ⚙️ Choix d'implémentation

### Utilisation de l'API SNCF (Objets Trouvés)

- **Accès aux données** : L'application récupère la liste des objets trouvés via l'API de la SNCF en utilisant des requêtes HTTP. Le package `http` est utilisé pour interagir avec l'API REST, ce qui permet de récupérer les données et les convertir en objet.
- **Filtrage des résultats** : Les données sont filtrées directement dans l'application selon les critères de l'utilisateur (gare d'origine, catégorie d'objet, etc.) avec l'utilisation des packages `filter_list` et `http`, ce qui offre une recherche personnalisée.

### Stockage local avec des fichiers

Pour le stockage de la date de dernière consultation, un `fichier` est utilisé en local pour la sauvegarder (lecture et écriture) lorsque l'application est lancée. Cependant `shared_preferences` pourrait être utiliser pour faire la même tâche.

### Gestion des états avec Provider

`Provider` est utilisé pour gérer les états de l'application de manière efficace. Il permet une séparation claire des responsabilités entre les différentes parties de l'application, facilitant la mise à jour dynamique de l'interface lorsque les données changent (nouveaux objets trouvés, filtres, etc.).

# Cloner le projet

- Pré-requis: Vous devez avoir un émulateur `android (avec Android Studio)` ou un émulateur `ios (avec Xcode)` et le `SDK flutter` installé sur votre ordinateur avec les versions suivantes de préférence :

  - `Flutter v3.24.1`
  - `Dart v3.5.1`

- Cloner le projet avec `git clone https://github.com/mayel15/sncf_found_objects.git`

- Aller dans le répertoire du projet

- Installer les dépendances avec `flutter packages get` ou `flutter pub add`

- Lancer l'application et consulter les objets trouvés 🥳
