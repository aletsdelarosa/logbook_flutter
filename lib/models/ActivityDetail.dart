import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum ActivityDetailType { OPEN_QUESTION, VALUES, DATE_TIME }

class ActivityDetail {
  final String title;

  ActivityDetail({@required this.title});

  toJSONEncodable() {}

  static ActivityDetail getActivityDetailFromJSON(dynamic detail) {
    if (detail['type'] == 'ActivityDetailDateTime') {
      return ActivityDetailDateTime(
        title: detail['title'],
        dateTime: DateFormat.yMd().add_jm().parse(detail['date_time']),
      );
    } else if (detail['type'] == 'ActivityDetailOpenQuestion') {
      return ActivityDetailOpenQuestion(
        title: detail['title'],
        placeholder: '',
        value: detail['value'],
      );
    } else {
      return ActivityDetailValues(
        title: detail['title'],
        hint: '',
        values: [],
        selectedValue: detail['selected_value'],
      );
    }
  }
}

class ActivityDetailDateTime extends ActivityDetail {
  DateTime dateTime;

  ActivityDetailDateTime({@required String title, this.dateTime})
      : super(title: title);

  @override
  Map<String, dynamic> toJSONEncodable() {
    Map<String, dynamic> map = new Map();

    map['title'] = this.title;
    map['type'] = 'ActivityDetailDateTime';
    map['date_time'] = DateFormat.yMd().add_jm().format(this.dateTime);
    return map;
  }
}

class ActivityDetailOpenQuestion extends ActivityDetail {
  final String placeholder;
  String value;

  ActivityDetailOpenQuestion(
      {@required String title, @required this.placeholder, this.value})
      : super(title: title);

  @override
  Map<String, dynamic> toJSONEncodable() {
    Map<String, dynamic> map = new Map();

    map['title'] = this.title;
    map['type'] = 'ActivityDetailOpenQuestion';
    map['value'] = this.value;
    return map;
  }
}

class ActivityDetailValues extends ActivityDetail {
  final List<String> values;
  final String hint;
  String selectedValue;
  ActivityDetailValues(
      {@required String title,
      @required this.values,
      @required this.hint,
      this.selectedValue})
      : super(title: title);

  @override
  Map<String, dynamic> toJSONEncodable() {
    Map<String, dynamic> map = new Map();

    map['title'] = this.title;
    map['type'] = 'ActivityDetailValues';
    map['selected_value'] = this.selectedValue;
    return map;
  }
}
