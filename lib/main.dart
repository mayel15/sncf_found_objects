import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sncf_found_objects/src/pages/home_page.dart';
import 'package:sncf_found_objects/src/services/sncf-found-object-api.service.dart';

Future<void> main() async {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SncfFoundObjectApiService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Objets Trouvés', routes: {
      '/': (context) => const HomePage(),
    });
  }
}
