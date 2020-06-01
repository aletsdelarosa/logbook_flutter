import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:log_book/models/Activity.dart';
import 'package:log_book/models/ActivityDetails.dart';
import 'package:log_book/models/Log.dart';
import 'package:path_provider/path_provider.dart';

class StorageManager {
  StorageManager._privateConstructor();
  static final StorageManager instance = StorageManager._privateConstructor();

  Future<String> get _localPath async {
    final directory = await getApplicationSupportDirectory();
    print(directory.path);
    return directory.path;
  }

  Future<File> saveToStorage(DateTime date, dynamic logs) async {
    final path = await _localPath;
    var dateString = DateFormat.yMd().format(date).replaceAll(RegExp('/'), '-');
    final file = File('$path/$dateString.json');
    var logsJSONEncoded = jsonEncode(logs);
    return file.writeAsString(logsJSONEncoded);
  }

  Future<List<Log>> getLogs(DateTime date) async {
    final path = await _localPath;
    var dateString = DateFormat.yMd().format(date).replaceAll(RegExp('/'), '-');
    final file = File('$path/$dateString.json');
    var logs;
    try {
      var fileExists = await file.exists();
      if(fileExists) {
        String contents = await file.readAsString();
        logs = jsonDecode(contents);
      }
    } catch (e) {
      print(e);
    }

    if (logs == null) {
      return [];
    }

    return List<Log>.from(
      (logs as List).map(
        (log) => Log(
          date: DateFormat.yMd().add_jm().parse((log['date'] as String)),
          activityType:
              Activity.convertStringToActivityType(log['activity_type']),
          details: ActivityDetails.getActivityDetailsFromJSON(log['details']),
        ),
      ),
    );
  }
}
