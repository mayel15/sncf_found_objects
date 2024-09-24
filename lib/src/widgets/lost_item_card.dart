import 'package:flutter/material.dart';

class LostItemCard extends StatelessWidget {
  final String itemName;
  final String stationName;
  final String category;
  final String date;

  const LostItemCard({
    required this.itemName,
    required this.stationName,
    required this.category,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              itemName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.train, size: 24), // Remplacez par l'icône que vous préférez
                SizedBox(width: 8), // Espacement entre l'icône et le texte
                Text(
                  stationName,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 8), // Espacement en dessous
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Espacement interne
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 30, 64, 103), // Couleur de fond bleu marine
                borderRadius: BorderRadius.circular(12.0), // Angles arrondis
              ),
              child: Text(
                category,
                style: TextStyle(
                  color: Colors.white, // Couleur du texte
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(height: 8),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Date: $date',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
