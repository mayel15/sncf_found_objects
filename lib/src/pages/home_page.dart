import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sncf_found_objects/src/models/found-object.model.dart';
import 'package:sncf_found_objects/src/services/sncf-found-object-api.service.dart';
import 'package:sncf_found_objects/src/widgets/filter_widget.dart';
import 'package:sncf_found_objects/src/widgets/found-object-card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Listes des objets perdus
  final List<FoundObjectModel> foundObjects = [
    FoundObjectModel(
        date: DateTime.parse('2018-02-14 09:28:40.000Z'),
        restitutionDate: null,
        originStationName: "Gare du nord",
        objectNature: "Téléphone",
        objectCategory: "Electronique"),
  ];

  // Les valeurs sélectionnées pour les filtres
  String? seletedOriginSatationName;
  String? selectedObjectCategory;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  @override
  Widget build(BuildContext context) {
    // Filtrer les objets en fonction des filtres sélectionnés
    // final filteredItems = lostItems.where((item) {
    //   final stationMatches =
    //       selectedStation == null || item['stationName'] == selectedStation;
    //   final categoryMatches =
    //       selectedCategory == null || item['category'] == selectedCategory;
    //   return stationMatches && categoryMatches;
    // }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('SNCF - Objets trouvés'),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
      ),
      body: Consumer<SncfFoundObjectApiService>(
          builder: (context, apiService, child) =>
              FutureBuilder<List<FoundObjectModel>>(
                future: apiService.filterFoundObjects(selectedObjectCategory,
                    selectedObjectCategory, selectedStartDate, selectedEndDate),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Widget foundObjectsListView = ListView.builder(
                      // itemCount: snapshot.data!.length,
                      itemCount: apiService.limitItems,
                      itemBuilder: (context, index) {
                        FoundObjectModel item = snapshot.data![index];
                        return FoundObjectCard(
                          item: item,
                        );
                      },
                    );
                    return foundObjectsListView;
                    //return Text(snapshot.data!.title);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // By default, show a loading spinner.
                  return const Center(child: CircularProgressIndicator());
                },
              )),
    );
  }
}

// Column(
          //   children: [
              // Widget de filtres avec le bouton de réinitialisation
              // FilterWidget(
              //   selectedStation: selectedStation,
              //   selectedCategory: selectedCategory,
              //   stations: stations,
              //   categories: categories,
              //   onStationChanged: (station) {
              //     setState(() {
              //       selectedStation = station;
              //     });
              //   },
              //   onCategoryChanged: (category) {
              //     setState(() {
              //       selectedCategory = category;
              //     });
              //   },
              //   onResetFilters: () {
              //     setState(() {
              //       selectedStation = null;
              //       selectedCategory = null;
              //     });
              //   },
              // ),
              // Liste des objets perdus filtrée
            //   Expanded(
            //     child: ListView.builder(
            //       itemCount: foundObjects.length,
            //       itemBuilder: (context, index) {
            //         FoundObjectModel item = foundObjects[index];
            //         return FoundObjectCard(
            //           item: item,
            //         );
            //       },
            //     ),
            //   ),
            // ],