import 'package:flutter/material.dart';
import 'package:sncf_found_objects/src/widgets/filter_widget.dart';
import 'package:sncf_found_objects/src/widgets/lost_item_card.dart'; 

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Listes des objets perdus
  final List<Map<String, String>> lostItems = [
    {
      'itemName': 'Sac à dos',
      'stationName': 'Gare de Lyon',
      'category': 'Bagage',
      'date': '12 Septembre 2024',
    },
    {
      'itemName': 'Téléphone',
      'stationName': 'Gare Montparnasse',
      'category': 'Électronique',
      'date': '15 Septembre 2024',
    },
    {
      'itemName': 'Clés',
      'stationName': 'Gare du Nord',
      'category': 'Clés',
      'date': '18 Septembre 2024',
    },
    {
      'itemName': 'Montre',
      'stationName': 'Gare de Lyon',
      'category': 'Montre',
      'date': '12 Septembre 2024',
    },
    {
      'itemName': 'Ordinateur',
      'stationName': 'Gare Montparnasse',
      'category': 'Électronique',
      'date': '15 Septembre 2024',
    },
    {
      'itemName': 'Portefeuille',
      'stationName': 'Gare du Nord',
      'category': 'Portefeuille',
      'date': '18 Septembre 2024',
    },
    {
      'itemName': 'Sac shopping',
      'stationName': 'Gare de Lyon',
      'category': 'Sac',
      'date': '12 Septembre 2024',
    },
  ];

  // Les valeurs sélectionnées pour les filtres
  String? selectedStation;
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    // Liste des gares et des catégories
    List<String> stations = [
      'Gare de Lyon',
      'Gare Montparnasse',
      'Gare du Nord',
    ];

    List<String> categories = [
      'Bagage',
      'Électronique',
      'Clés',
      'Montre',
      'Portefeuille',
      'Sac',
    ];

    // Filtrer les objets en fonction des filtres sélectionnés
    final filteredItems = lostItems.where((item) {
      final stationMatches = selectedStation == null || item['stationName'] == selectedStation;
      final categoryMatches = selectedCategory == null || item['category'] == selectedCategory;
      return stationMatches && categoryMatches;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('SNCF - Objets trouvés'),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
      ),
      body: Column(
        children: [
          // Widget de filtres avec le bouton de réinitialisation
          FilterWidget(
            selectedStation: selectedStation,
            selectedCategory: selectedCategory,
            stations: stations,
            categories: categories,
            onStationChanged: (station) {
              setState(() {
                selectedStation = station;
              });
            },
            onCategoryChanged: (category) {
              setState(() {
                selectedCategory = category;
              });
            },
            onResetFilters: () {
              setState(() {
                selectedStation = null;
                selectedCategory = null;
              });
            },
          ),
          // Liste des objets perdus filtrée
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return LostItemCard(
                  itemName: item['itemName']!,
                  stationName: item['stationName']!,
                  category: item['category']!,
                  date: item['date']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}