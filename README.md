# Definition of Done (DoD) — StoryBlocks

Cette DoD s’applique à toute User Story / Issue terminée.

## 1) Fonctionnel

 La fonctionnalité demandée est implémentée et correspond à la description de l’issue.
 Les critères d’acceptation de l’issue sont respectés (ou mis à jour et approuvés).
 Les cas d’erreur sont gérés (ex: champs obligatoires, QR invalide, carton introuvable).
 Aucun crash connu sur le parcours principal.
## 2) Qualité de code

 Le code est lisible (noms clairs, pas de code mort, pas de TODO oubliés).
 L’architecture du projet est respectée (UI / logique / data séparés selon vos conventions).
 Les changements sont limités au scope de l’issue (pas de refactor “gratuit” non lié).
## 3) Tests
Minimum requis selon le type de travail :

 Si logique métier / data : tests unitaires ajoutés ou mis à jour.
 Si UI critique : au moins 1 test widget (smoke test) ou une justification écrite si non applicable.
 Tous les tests passent localement :
flutter test
## 4) Build / Lint / Analyse

 flutter analyze ne rapporte aucune erreur (warnings acceptés seulement si justifiés).
 Le projet compile (au minimum sur la/les plateforme(s) ciblée(s)) :
Android : flutter build apk ou flutter run sur émulateur/appareil
 Aucune dépendance cassée : flutter pub get fonctionne.
## 5) UX / UI

 Les textes sont compréhensibles (FR cohérent), pas de libellés “placeholder”.
 Les états sont gérés : chargement / vide / erreur.
 Navigation OK (retour arrière, ouverture écran détail, etc.).
## 6) Données & Persistance (si applicable)

 Les données créées/modifiées sont persistées correctement (après redémarrage de l’app).
 Les changements de modèle (si DB) incluent migration ou stratégie équivalente.
 Aucun fichier local dépendant de la machine n’est commité (ex: android/local.properties).
**## 7) Git / PR **

 La branche est à jour avec main si nécessaire.
 Le commit message est clair et lié à l’issue (ex: #12 Add carton creation screen).
 La PR contient : description + capture(s) si UI.
 Revue : au moins 1 approbation (ou règle d’équipe).
 CI verte (si configurée).
## 8) Documentation

 Si l’usage a changé : README / doc mise à jour (ou note dans la PR).
 Si nouvelle dépendance/permission : documentée (ex: caméra pour QR).
### Definition of Ready

 L’issue a des critères d’acceptation clairs.
 Les maquettes/écrans attendus sont connus (ou “best effort” accepté).
 Dépendances identifiées (ex: lib QR, permissions).

# StoryBlocks

**StoryBlocks** est une application mobile (Flutter) qui permet de **construire des histoires bloc par bloc** : personnage, lieu, objectif, obstacle, twist, fin, ton… puis de générer un texte à lire, copier, et sauvegarder.

> UI en **français**, nom du projet en **anglais**.

---

## Objectifs (MVP)

- Construire une histoire via des **blocs narratifs**
- **Générer** un texte à partir des choix
- **Régénérer** une variation
- **Copier** l’histoire
- (Optionnel mais recommandé) **Sauvegarder** et retrouver ses histoires dans *Mes histoires* (stockage local)

---

## Fonctionnalités

### Création
- Sélection de blocs :
  - Personnage
  - Lieu
  - Objectif
  - Obstacle
  - Twist (rebondissement)
  - Fin
  - Ton (drôle / sombre / poétique / neutre)

### Lecture
- Affichage du titre + texte généré
- Actions : **Copier**, **Régénérer**
- (Optionnel) **Sauvegarder**, **Partager**

### Bibliothèque (local)
- Liste **Mes histoires**
- Détail d’une histoire
- Suppression

---

## Tech stack

- **Flutter** (Android + iOS)
- **Material 3**
- (Recommandé) `go_router` pour la navigation
- (Recommandé) `flutter_riverpod` pour la gestion d’état
- (Recommandé) `hive` / `hive_flutter` pour la persistance locale
- (Optionnel) `share_plus` pour le partage

---

## Installation & lancement

### Prérequis
- Flutter SDK installé
- Android Studio (et/ou Xcode sur macOS pour iOS)
- Un émulateur Android ou un appareil physique

### Lancer le projet
```bash
flutter pub get
flutter run
```

---

## Organisation du projet (suggestion)

- `lib/`
  - `app/` (routing, thème)
  - `features/`
    - `builder/`
    - `reader/`
    - `stories/`
  - `core/`
    - `models/`
    - `story_engine/`
    - `storage/`

---

## Backlog / Suivi

Le backlog est géré via les **Issues GitHub** avec :
- labels : `P0`, `P1`, `P2`, `ui`, `story-engine`, `storage`, `navigation`, `polish`, `user story`
- milestone : `MVP-2026-04-04`

---

## Roadmap (date cible)

Objectif : **livraison MVP avant le 2026-04-04**.

1. P0 : Builder + génération + lecture + copie + régénération  
2. P1 : sauvegarde locale (Hive) + Mes histoires  
3. P2 : partage, polish UI, animations

---

## Licence

Projet de portfolio / école. Licence à définir (ex: MIT).
