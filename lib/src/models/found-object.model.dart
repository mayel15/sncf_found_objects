import 'package:intl/intl.dart';

class FoundObjectModel {
  final DateTime date;
  final DateTime? restitutionDate;
  final String? originStationName;
  final String objectNature;
  final String objectCategory;

  FoundObjectModel({
    required this.date,
    required this.restitutionDate,
    required this.originStationName,
    required this.objectNature,
    required this.objectCategory,
  });

  factory FoundObjectModel.fromJson(dynamic json) {
    return switch (json) {
      {
        'date': String date,
        'gc_obo_date_heure_restitution_c': String? restitutionDate,
        'gc_obo_gare_origine_r_name': String? originStationName,
        'gc_obo_nature_c': String objectNature,
        'gc_obo_type_c': String objectCategory,
      } =>
        FoundObjectModel(
          date: DateTime.parse(date),
          restitutionDate:
              restitutionDate != null ? DateTime.parse(restitutionDate) : null,
          originStationName: originStationName,
          objectNature: objectNature,
          objectCategory: objectCategory,
        ),
      _ => throw const FormatException('Failed to load object.'),
    };
  }

  @override
  String toString() {
    return 'FoundObjectModel(date: $date, restitutionDate: $restitutionDate, originStationName: $originStationName, objectNature: $objectNature, objectCategory: $objectCategory)';
  }
}
