import 'package:flutter/material.dart';
import 'package:sncf_found_objects/src/models/found-object.model.dart';

class FoundObjectCard extends StatelessWidget {
  final FoundObjectModel item;

  const FoundObjectCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.objectNature,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.train,
                    size: 24), // Remplacez par l'icône que vous préférez
                const SizedBox(
                    width: 8), // Espacement entre l'icône et le texte
                Text(
                  item.originStationName,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8), // Espacement en dessous
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 4.0), // Espacement interne
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                    255, 30, 64, 103), // Couleur de fond bleu marine
                borderRadius: BorderRadius.circular(12.0), // Angles arrondis
              ),
              child: Text(
                item.objectCategory,
                style: const TextStyle(
                  color: Colors.white, // Couleur du texte
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                item.date.toIso8601String(),
                style: const TextStyle(color: Colors.black, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
