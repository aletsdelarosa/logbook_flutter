import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:log_book/models/Activity.dart';
import 'package:log_book/models/ActivityDetails.dart';
import 'package:log_book/models/StorageManager.dart';

class Log {
  final DateTime date;
  final ActivityType activityType;
  final ActivityDetails details;

  Log({@required this.date, @required this.activityType, @required this.details});

  Map<String, dynamic> toJSONEncodable() {
    Map<String, dynamic> map = new Map();

    map['date'] = DateFormat.yMd().add_jm().format(this.date);
    map['activity_type'] = this.activityType.toString();
    map['details'] = this.details.toJSONEncodable();
    return map;
  }
}

class Logs {
  Logs._privateConstructor();

  static final Logs instance = Logs._privateConstructor();

  List<Log> _todaysLogs;
  DateTime currentDateTime = DateTime.now();

  Future<List<Log>> getTodaysLogs() async {
    DateTime now = DateTime.now();
    if(_todaysLogs == null) {
      this._todaysLogs = await StorageManager.instance.getLogs(now);
    }
    else if(currentDateTime.day != now.day || currentDateTime.month != now.month || currentDateTime.year != now.year) {
      this._todaysLogs = await StorageManager.instance.getLogs(now);
      this.currentDateTime = now;
    }

    return this._todaysLogs;
  }

  Future<List<Log>> getLogsForDay({@required DateTime date}) {
    return StorageManager.instance.getLogs(date);
  }

  Future<void> addLog({@required DateTime date, @required ActivityType activityType, @required ActivityDetails details}) async {
    this._todaysLogs.add(Log(activityType: activityType, date: date, details: details));
    this._todaysLogs.sort((log1, log2) {
      return log1.date.isAfter(log2.date) ? 1 : -1;
    });

    var _ = await StorageManager.instance.saveToStorage(date, _todaysLogsToJSONEncodable());
  }

  List<Map<String, dynamic>> _todaysLogsToJSONEncodable() {
   return _todaysLogs.map((log) {
      return log.toJSONEncodable();
    }).toList();
  }
}


