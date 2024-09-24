import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sncf_found_objects/src/models/found-object.model.dart';
import 'package:http/http.dart' as http;

class SncfFoundObjectApiService extends ChangeNotifier {
  final apiUrl =
      'https://data.sncf.com/api/explore/v2.1/catalog/datasets/objets-trouves-restitution/records';
  final limitItems = 5;

  Future<List<FoundObjectModel>> getAllFoundObjects() async {
    try {
      // If the server did return a 200 OK response,
      final response = await http.get(Uri.parse(apiUrl),
          headers: {"Content-Type": "application/json"});
      final data = jsonDecode(response.body);
      final dataResultsField = data['results'] as List;
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

  Future<List<FoundObjectModel>> filterFoundObjects(String? objectCategory,
      String? originStationName, DateTime? startDate, DateTime? endDate) async {
    final foundObjects = await getAllFoundObjects();
    List<FoundObjectModel> foundObjectsFiltered = foundObjects;
    // print("found objects : $foundObjects");
    if (objectCategory != null) {
      foundObjectsFiltered = foundObjects
          .where((element) => element.objectCategory == objectCategory)
          .toList();
      // print("found objects after removing category : $foundObjects");
    }
    if (originStationName != null) {
      foundObjectsFiltered = foundObjectsFiltered
          .where((element) => element.originStationName == originStationName)
          .toList();
      // print("found objects after removing origin station : $foundObjects");
    }
    if (startDate != null) {
      foundObjectsFiltered = foundObjects
          .where((element) => element.date.isAfter(startDate))
          .toList();
      // print("found objects after removing start date : $foundObjects");
    }
    if (endDate != null) {
      foundObjectsFiltered = foundObjects
          .where((element) => element.date.isBefore(endDate))
          .toList();
      // print("found objects after removing end date : $foundObjects");
    }
    notifyListeners();

    return foundObjectsFiltered;
  }

  Future<List<FoundObjectModel>> getFoundObjectsFromLastConsulationDate(
      DateTime date) async {
    return await filterFoundObjects(null, null, date, null);
  }
}

void main() {
  final sncfFoundObjectApiService = SncfFoundObjectApiService();

  // get all found objects
  sncfFoundObjectApiService.getAllFoundObjects().then((data) {
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
  sncfFoundObjectApiService
      .filterFoundObjects(
          "Pièces d'identité et papiers personnels",
          "Toulouse Matabiau",
          DateTime.parse('2018-08-28T13:58:33+00:00'),
          DateTime.parse('2019-10-10T13:58:33+00:00'))
      .then((data) => print("found objects data by filters all: $data"));

  // get found objects by only date range : OK
  sncfFoundObjectApiService
      .filterFoundObjects(
          null, null, DateTime.parse('2018-02-14 09:28:40.000Z'), null)
      .then((data) => print("found objects data by only date range: $data"));

  // // get found objects by only origin station : OK
  sncfFoundObjectApiService
      .filterFoundObjects(null, "Lille Flandres", null, null)
      .then(
          (data) => print("found objects data by only origin station: $data"));

  // // get found objects by only object category : OK
  sncfFoundObjectApiService
      .filterFoundObjects(
          "Pièces d'identités et papiers personnels", null, null, null)
      .then(
          (data) => print("found objects data by only object category: $data"));

  // get found objects by only date range and origin station : OK
  sncfFoundObjectApiService
      .filterFoundObjects(null, "Lille Flandres", null, null)
      .then((data) => print(
          "found objects data by only date range and origin station: $data"));

  // get found objects by only object category and origin station
  sncfFoundObjectApiService
      .filterFoundObjects("Pièces d'identité et papiers personnels",
          "Toulouse Matabiau", null, null)
      .then((data) => print(
          "found objects data by only object category and origin station: $data"));

  // get found objects by only date range and object category
  sncfFoundObjectApiService
      .filterFoundObjects(
          "Pièces d'identité et papiers personnels", null, null, null)
      .then((data) => print(
          "found objects data by only date range and object category: $data"));
}
