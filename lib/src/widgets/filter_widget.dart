import 'package:flutter/material.dart';

class FilterWidget extends StatelessWidget {
  final String? selectedStation;
  final String? selectedCategory;
  final List<String> stations;
  final List<String> categories;
  final ValueChanged<String?> onStationChanged;
  final ValueChanged<String?> onCategoryChanged;
  final VoidCallback onResetFilters; // Nouvelle fonction de réinitialisation

  const FilterWidget({
    required this.selectedStation,
    required this.selectedCategory,
    required this.stations,
    required this.categories,
    required this.onStationChanged,
    required this.onCategoryChanged,
    required this.onResetFilters, // Assurez-vous de passer cette fonction
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Filtre par Gare d'origine avec icône
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black, // Couleur de fond noire
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    // Ouvrir le menu déroulant pour les gares
                    showMenu<String>(
                      context: context,
                      position: RelativeRect.fromLTRB(100, 100, 0, 0),
                      items: stations.map((station) {
                        return PopupMenuItem<String>(
                          value: station,
                          child: Text(station),
                        );
                      }).toList(),
                    ).then((value) {
                      if (value != null) {
                        onStationChanged(value);
                      }
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.train,
                      color: Colors.white, // Couleur de l'icône
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 2), // Espace entre les filtres

          // Filtre par Catégorie avec icône
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black, // Couleur de fond noire
              ),
              child: Material(
                color: Colors.transparent, // Transparente pour éviter la couleur par défaut
                child: InkWell(
                  borderRadius: BorderRadius.circular(30), // Pour arrondir les coins
                  onTap: () {
                    // Ouvrir le menu déroulant pour les catégories
                    showMenu<String>(
                      context: context,
                      //position: center
                      position: RelativeRect.fromLTRB(100, 100, 0, 0),
                      items: categories.map((category) {
                        return PopupMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                    ).then((value) {
                      if (value != null) {
                        onCategoryChanged(value);
                      }
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0), // Ajoutez un padding pour un meilleur espacement
                    child: Icon(
                      Icons.category,
                      color: Colors.white, // Couleur de l'icône
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 2), // Espace entre les filtres

          // Bouton pour réinitialiser les filtres
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black, // Couleur de fond noire
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: onResetFilters, // Appelle la fonction pour réinitialiser les filtres
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.refresh, // Icône de réinitialisation
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
