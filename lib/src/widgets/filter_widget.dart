import 'package:flutter/material.dart';

class FilterWidget extends StatelessWidget {
  final String? selectedStation;
  final String? selectedCategory;
  final String? selectedDate;
  final List<String> stations;
  final List<String> categories;
  final List<String> dates;
  final ValueChanged<String?> onStationChanged;
  final ValueChanged<String?> onCategoryChanged;
  final ValueChanged<String?> onDateChanged;

  const FilterWidget({
    required this.selectedStation,
    required this.selectedCategory,
    required this.selectedDate,
    required this.stations,
    required this.categories,
    required this.dates,
    required this.onStationChanged,
    required this.onCategoryChanged,
    required this.onDateChanged,
  });


Widget build(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Filtre par Gare d'origine avec icône
        Expanded(
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              icon: Icon(Icons.train), // Icône pour la gare d'origine
              isExpanded: true, // Permet d'occuper tout l'espace disponible
              value: null,
              onChanged: onStationChanged,
              items: stations.map((station) {
                return DropdownMenuItem(
                  value: station,
                  child: Text(station), // Affiche le texte dans le menu
                );
              }).toList(),
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
                  // Ouvrir le menu déroulant
                  showMenu<String>(
                    context: context,
                    position: RelativeRect.fromLTRB(100, 100, 0, 0), // Ajustez la position selon vos besoins
                    items: categories.map((category) {
                      return PopupMenuItem<String>(
                        value: category,
                        child: Text(category), // Affiche le texte dans le menu
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


        // Filtre par Date avec icône
        Expanded(
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              icon: Icon(Icons.date_range), // Icône pour la date
              isExpanded: true,
              value: null,
              onChanged: onDateChanged,
              items: dates.map((date) {
                return DropdownMenuItem(
                  value: date,
                  child: Text(date), // Affiche le texte dans le menu
                );
              }).toList(),
            ),
          ),
        ),
      ],
    ),
  );
}
}
