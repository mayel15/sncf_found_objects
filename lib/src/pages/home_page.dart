import 'package:flutter/material.dart';
import 'package:sncf_found_objects/src/widgets/lost_item_card.dart'; 

class HomePage extends StatelessWidget {
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
    //une montre
    {
      'itemName': 'Montre',
      'stationName': 'Gare de Lyon',
      'category': 'Montre',
      'date': '12 Septembre 2024',
    },
    //un ordinateur
    {
      'itemName': 'Ordinateur',
      'stationName': 'Gare Montparnasse',
      'category': 'Électronique',
      'date': '15 Septembre 2024',
    },
    //un portefeuille
    {
      'itemName': 'Portefeuille',
      'stationName': 'Gare du Nord',
      'category': 'Portefeuille',
      'date': '18 Septembre 2024',
    },
    //un sac shopping
    {
      'itemName': 'Sac shopping',
      'stationName': 'Gare de Lyon',
      'category': 'Sac',
      'date': '12 Septembre 2024',
    },
    
    // Ajoutez d'autres objets ici
  ];

  HomePage({super.key});

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('SNCF - Objets trouvés'),
      centerTitle: true,
      backgroundColor: Colors.grey[200],
    ),
    body: Column(
        children: [
          // Si vous avez d'autres widgets ici
          Expanded(
            child: ListView.builder(
              itemCount: lostItems.length,
              itemBuilder: (context, index) {
                final item = lostItems[index];
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
