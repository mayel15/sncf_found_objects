import 'package:flutter/material.dart';
import 'package:sncf_found_objects/src/pages/home_page.dart'; // Importez votre page Home

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Objets Trouvés',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(), // Définir la page Home ici
    );
  }
}
