import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sncf_found_objects/src/models/found-object.model.dart';
import 'package:sncf_found_objects/src/services/file.service.dart';
import 'package:sncf_found_objects/src/services/sncf-found-object-api.service.dart';
import 'package:sncf_found_objects/src/widgets/found-object-card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String?> seletedOriginStationNamesList = [];
  List<String?> selectedObjectCategoriesList = [];
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  DateTimeRange selectedDateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );

  final currentMonth = DateTime.now().month;

  @override
  void initState() {
    super.initState();
    updateLastConsultationDate(DateTime.now());
    //fileService.writeLastConsulationDate("2024-10-01");
  }

  void updateLastConsultationDate(DateTime date) {
    FileService fileService = FileService();
    fileService.writeLastConsulationDate(date.toString());
  }

  void handleDateRangeSelected(BuildContext context) async {
    final DateTimeRange? dateTimeRangePicked = await showDateRangePicker(
        context: context,
        firstDate: DateTime.parse("2024-$currentMonth-01"),
        lastDate: DateTime.now()); // range is only from 2000 to
    if (dateTimeRangePicked != null) {
      setState(() {
        selectedStartDate = dateTimeRangePicked.start;
        selectedEndDate = dateTimeRangePicked.end;
      });
    }
  }

  // Listes des objets perdus
  final List<FoundObjectModel> foundObjects = [
    FoundObjectModel(
        date: DateTime.parse('2018-02-14 09:28:40.000Z'),
        restitutionDate: null,
        originStationName: "Gare du nord",
        objectNature: "Téléphone",
        objectCategory: "Electronique"),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    void openFilterOriginStationDialog(List<String> originStationList) async {
      await FilterListDialog.display<String>(
        context,
        listData: originStationList,
        selectedListData:
            seletedOriginStationNamesList.whereType<String>().toList(),
        choiceChipLabel: (category) => category,
        validateSelectedItem: (list, val) => list!.contains(val),
        onItemSearch: (category, query) {
          return category.toLowerCase().contains(query.toLowerCase());
        },
        onApplyButtonClick: (list) {
          setState(() {
            list!.isEmpty
                ? seletedOriginStationNamesList = []
                : seletedOriginStationNamesList = list;
          });
          Navigator.pop(context);
        },
        resetButtonText: "Reinitialiser",
        applyButtonText: "Appliquer",
        allButtonText: "Tout",
        selectedItemsText: "gares sélectionnées",
      );
    }

    void openFilterCategoryDialog(List<String> categoryList) async {
      await FilterListDialog.display<String>(
        context,
        listData: categoryList,
        selectedListData:
            selectedObjectCategoriesList.whereType<String>().toList(),
        choiceChipLabel: (category) => category,
        validateSelectedItem: (list, val) => list!.contains(val),
        onItemSearch: (category, query) {
          return category.toLowerCase().contains(query.toLowerCase());
        },
        onApplyButtonClick: (list) {
          setState(() {
            list!.isEmpty
                ? selectedObjectCategoriesList = []
                : selectedObjectCategoriesList = list;
          });
          Navigator.pop(context);
        },
        resetButtonText: "Reinitialiser",
        applyButtonText: "Appliquer",
        allButtonText: "Tout",
        selectedItemsText: "catégories sélectionnées",
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('SNCF - Objets trouvés'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(217, 217, 217, 217),
      ),
      body: Consumer<SncfFoundObjectApiService>(
          builder: (context, apiService, child) =>
              FutureBuilder<List<FoundObjectModel>>(
                future: apiService.filterFoundObjects(
                    selectedObjectCategoriesList,
                    seletedOriginStationNamesList,
                    selectedStartDate,
                    selectedEndDate),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Widget> foundObjects = [];
                    for (FoundObjectModel item in snapshot.data!) {
                      foundObjects.add(FoundObjectCard(
                        item: item,
                      ));
                    }
                    Widget foundObjectsListView = ListView(
                      children: foundObjects,
                    );
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                MaterialButton(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0, vertical: 8.0),
                                  color: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: const Icon(Icons.train,
                                      color: Colors.white, size: 24.0),
                                  onPressed: () async => {
                                    openFilterOriginStationDialog(
                                        await apiService
                                            .getOriginStationList()
                                            .then((data) => data
                                                .whereType<String>()
                                                .toList()))
                                  },
                                ),
                                MaterialButton(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0, vertical: 8.0),
                                  color: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: const Icon(Icons.category,
                                      color: Colors.white, size: 24.0),
                                  onPressed: () async => {
                                    openFilterCategoryDialog(await apiService
                                        .getObjectCategoriesList()
                                        .then((data) =>
                                            data.whereType<String>().toList()))
                                  },
                                ),
                                MaterialButton(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0, vertical: 8.0),
                                  color: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: const Icon(Icons.date_range,
                                      color: Colors.white, size: 24.0),
                                  onPressed: () async => {
                                    handleDateRangeSelected(
                                      context,
                                    )
                                  },
                                ),
                                MaterialButton(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0, vertical: 8.0),
                                  color: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: const Icon(Icons.refresh,
                                      color: Colors.white, size: 24.0),
                                  onPressed: () async => {
                                    setState(() {
                                      selectedObjectCategoriesList = [];
                                      seletedOriginStationNamesList = [];
                                      selectedStartDate = null;
                                      selectedEndDate = null;
                                      updateLastConsultationDate(DateTime.parse(
                                          "2024-$currentMonth-01"));
                                    })
                                  },
                                ),
                              ]),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 16),
                          child: const Text(
                            "Liste des objets",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                        ),
                        Expanded(
                            child: foundObjects.isEmpty
                                ? const Center(
                                    child: Text("Aucun objet trouvé",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 24)),
                                  )
                                : foundObjectsListView),
                      ],
                    );
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
