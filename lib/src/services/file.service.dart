import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/last-consultation.txt');
  }

  Future<File> writeLastConsulationDate(String lastConsultationDate) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(lastConsultationDate);
  }

  Future<String> readLastConsulationDate() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();
      print("last consultation : $contents");

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return '0';
    }
  }
}
