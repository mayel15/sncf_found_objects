import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sncf_found_objects/src/models/found-object.model.dart';
import 'package:http/http.dart' as http;
import 'package:sncf_found_objects/src/services/file.service.dart';
import 'package:sncf_found_objects/src/widgets/found-object-card.dart';

class SncfFoundObjectApiService extends ChangeNotifier {
  final apiUrl =
      'https://data.sncf.com/api/explore/v2.1/catalog/datasets/objets-trouves-restitution/records';

  final limitItems = 100;
  final fileService = FileService();

  Future<List<FoundObjectModel>> getAllFoundObjects(String startDate) async {
    try {
      // If the server did return a 200 OK response,
      final response = await http.get(
          Uri.parse("$apiUrl?where=date>\"$startDate\"&limit=$limitItems"),
          headers: {"Content-Type": "application/json"});
      final data = json.decode(response.body);
      final dataResultsField = data['results'] as List;
      // print("dataResultsField : $dataResultsField");
      final foundObjectsData =
          dataResultsField.map((e) => FoundObjectModel.fromJson(e)).toList();
      return foundObjectsData;
    } catch (error) {
      print("an error occured : $error");
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load FoundObjectModel');
    }
  }

  Future<List<String?>> getOriginStationList() async {
    try {
      final response = await http.get(
          Uri.parse(
              "$apiUrl?group_by=gc_obo_gare_origine_r_name&limit=$limitItems"),
          headers: {"Content-Type": "application/json"});
      final data = jsonDecode(response.body);
      final dataResultsField = data['results'] as List;
      final originStations = dataResultsField
          .map((e) => e['gc_obo_gare_origine_r_name'] as String?)
          .toList();
      return originStations;
    } catch (error) {
      throw Exception('Failed to load FoundObjectModel');
    }
  }

  Future<List<String?>> getObjectCategoriesList() async {
    try {
      final response = await http.get(
          Uri.parse("$apiUrl?group_by=gc_obo_type_c&limit=$limitItems"),
          headers: {"Content-Type": "application/json"});
      final data = jsonDecode(response.body);
      final dataResultsField = data['results'] as List;
      final objectCategories =
          dataResultsField.map((e) => e['gc_obo_type_c'] as String?).toList();
      return objectCategories;
    } catch (error) {
      throw Exception('Failed to load FoundObjectModel');
    }
  }

  Future<List<FoundObjectModel>> filterFoundObjects(
      List<String?> objectCategoriesList,
      List<String?> originStationNamesList,
      DateTime? startDate,
      DateTime? endDate) async {
    String lastConsultationDate = await fileService.readLastConsulationDate();
    // lastConsultationDate = "2024-08-01";
    // final foundObjects = await getAllFoundObjects(
    //     lastConsultationDate.toString() ?? "2024-01-01");

    final currentMonth = DateTime.now().month;
    // all the found objects in the current month
    final foundObjects = await getAllFoundObjects(
        lastConsultationDate ?? "2024-$currentMonth-01");

    List<FoundObjectModel> foundObjectsFiltered = foundObjects;
    // print("found objects : $foundObjects");
    // print("filtered objects : $foundObjectsFiltered");
    if (objectCategoriesList.isNotEmpty) {
      foundObjectsFiltered = foundObjects
          .where((element) =>
              objectCategoriesList.contains(element.objectCategory))
          .toList();
    }
    if (originStationNamesList.isNotEmpty) {
      foundObjectsFiltered = foundObjectsFiltered
          .where((element) =>
              originStationNamesList.contains(element.originStationName))
          .toList();
    }
    if (startDate != null) {
      foundObjectsFiltered = foundObjectsFiltered
          .where((element) => element.date.isAfter(startDate))
          .toList();
    }
    if (endDate != null) {
      foundObjectsFiltered = foundObjectsFiltered
          .where((element) => element.date.isBefore(endDate))
          .toList();
    }
    // print(foundObjectsFiltered);

    return foundObjectsFiltered;
  }

  Future<List<FoundObjectModel>> getFoundObjectsFromLastConsulationDate(
      DateTime date) async {
    return await filterFoundObjects([], [], date, null);
  }
}

void main() {
  final sncfFoundObjectApiService = SncfFoundObjectApiService();

  // get all found objects
  sncfFoundObjectApiService
      .getAllFoundObjects(DateTime.now().toString())
      .then((data) {
    print("found objects data : $data");
  });

  // // get origin stations list
  sncfFoundObjectApiService.getOriginStationList().then((data) {
    print("origin stations data : $data");
  });

  // get categories
  sncfFoundObjectApiService
      .getObjectCategoriesList()
      .then((data) => print("object categories data: $data"));

  //
  // apply filters
  //

  // get found objects by applying all filters
  sncfFoundObjectApiService.filterFoundObjects(
      ["Pièces d'identité et papiers personnels"],
      ["Toulouse Matabiau"],
      DateTime.parse('2018-08-28T13:58:33+00:00'),
      DateTime.parse(
          '2019-10-10T13:58:33+00:00')).then(
      (data) => print("found objects data by filters all: $data"));

  // get found objects by only date range : OK
  sncfFoundObjectApiService.filterFoundObjects([], [],
      DateTime.parse('2018-02-14 09:28:40.000Z'),
      null).then((data) => print("found objects data by only date range: $data"));

  // // get found objects by only origin station : OK
  sncfFoundObjectApiService
      .filterFoundObjects([], ["Lille Flandres"], null, null).then(
          (data) => print("found objects data by only origin station: $data"));

  // // get found objects by only object category : OK
  sncfFoundObjectApiService.filterFoundObjects([
    "Pièces d'identités et papiers personnels"
  ], [], null, null).then(
      (data) => print("found objects data by only object category: $data"));

  // get found objects by only date range and origin station : OK
  sncfFoundObjectApiService.filterFoundObjects([], [
    "Lille Flandres"
  ], null, null).then((data) =>
      print("found objects data by only date range and origin station: $data"));

  // get found objects by only object category and origin station
  sncfFoundObjectApiService.filterFoundObjects([
    "Pièces d'identité et papiers personnels"
  ], [
    "Toulouse Matabiau"
  ], null, null).then((data) => print(
      "found objects data by only object category and origin station: $data"));

  // get found objects by only date range and object category
  sncfFoundObjectApiService.filterFoundObjects([
    "Pièces d'identité et papiers personnels"
  ], [], null, null).then((data) => print(
      "found objects data by only date range and object category: $data"));
}
