import 'dart:convert';
import 'package:sncf_found_objects/src/models/found-object.model.dart';
import 'package:http/http.dart' as http;

class SncfFoundObjectApiService {
  final apiUrl =
      'https://data.sncf.com/api/explore/v2.1/catalog/datasets/objets-trouves-restitution/records';
  final limitItems = 10;

  Future<List<FoundObjectModel>> getFoundObject() async {
    final response = await http
        .get(Uri.parse(apiUrl), headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      final data = jsonDecode(response.body);
      final dataResultsField = data['results'] as List;
      final foundObjectsData =
          dataResultsField.map((e) => FoundObjectModel.fromJson(e)).toList();
      return foundObjectsData;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load FoundObjectModel');
    }
  }

  Future<List<String?>> getOriginStationList() async {
    final response = await http.get(
        Uri.parse(
            "$apiUrl?group_by=gc_obo_gare_origine_r_name&limit=$limitItems"),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      final data = jsonDecode(response.body);
      final dataResultsField = data['results'] as List;
      final originStations = dataResultsField
          .map((e) => e['gc_obo_gare_origine_r_name'] as String?)
          .toList();
      return originStations;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load FoundObjectModel');
    }
  }

  Future<List<FoundObjectModel>> getFoundObjectsByOriginStationName(
      String originStationName) async {
    final response = await http.get(
        Uri.parse(
            "$apiUrl?where=gc_obo_gare_origine_r_name='$originStationName'"),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      final data = jsonDecode(response.body);
      final dataResultsField = data['results'] as List;
      final foundObjectsData =
          dataResultsField.map((e) => FoundObjectModel.fromJson(e)).toList();
      return foundObjectsData;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load FoundObjectModel');
    }
  }

  Future<List<FoundObjectModel>> getFoundObjectsByDateRange(
      DateTime startDate, DateTime endDate) async {
    try {
      final response = await http.get(
          Uri.parse("$apiUrl?where=date>='$startDate'&date<='$endDate'"),
          headers: {"Content-Type": "application/json"});
      final data = jsonDecode(response.body);
      final dataResultsField = data['results'] as List;
      final foundObjectsData =
          dataResultsField.map((e) => FoundObjectModel.fromJson(e)).toList();
      return foundObjectsData;
    } catch (e) {
      throw Exception('Failed to load FoundObjectModel');
    }
  }
}

void main() {
  final sncfFoundObjectApiService = SncfFoundObjectApiService();
  // sncfFoundObjectApiService.getFoundObject().then((data) {
  //   print("found objects data : $data");
  // });

  // sncfFoundObjectApiService.getOriginStationList().then((data) {
  //   print("origin stations data : $data");
  // });

  // sncfFoundObjectApiService
  //     .getFoundObjectsByOriginStationName("Clermont-Ferrand")
  //     .then((data) {
  //   print("found objects data : $data");
  // });

  sncfFoundObjectApiService
      .getFoundObjectsByDateRange(DateTime.parse('2019-08-28T13:58:33+00:00'),
          DateTime.parse('2019-10-10T13:58:33+00:00'))
      .then((data) => print("data: $data"));
}
