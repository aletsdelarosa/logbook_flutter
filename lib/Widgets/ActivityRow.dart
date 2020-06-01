import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:log_book/models/Activity.dart';
import 'package:log_book/models/Log.dart';

class ActivityRow extends StatelessWidget {
  final Log log;

  ActivityRow({@required this.log});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Activity.getActivityIcon(activityType: log.activityType)),
      title: Text(Activity.getActivityText(activityType: log.activityType)),
      subtitle: Text(DateFormat.jm(Localizations.localeOf(context).languageCode).format(log.date)),
    );
  }
}
