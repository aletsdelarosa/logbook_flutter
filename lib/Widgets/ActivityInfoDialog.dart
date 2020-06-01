import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:log_book/models/Activity.dart';
import 'package:log_book/models/ActivityDetail.dart';
import 'package:log_book/models/Log.dart';

class ActivityInfoDialog extends StatefulWidget {
  final Log log;

  ActivityInfoDialog({@required this.log});

  @override
  _ActivityInfoDialogState createState() =>
      _ActivityInfoDialogState(log: this.log);
}

class _ActivityInfoDialogState extends State<ActivityInfoDialog> {
  final Log log;

  DateTime date = DateTime.now();
  List<ActivityDetail> activityDetails;
  _ActivityInfoDialogState({@required this.log});

  @override
  void initState() {
    super.initState();
    this.activityDetails = log.details.detailsInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Center(child: _dialogContent(context)),
    );
  }

  _dialogContent(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        padding: EdgeInsets.all(16.0),
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: LimitedBox(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: _buildListOfWidgets(activityType: log.activityType),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListOfWidgets({@required ActivityType activityType}) {
    List<Widget> widgets = [
      Text(
        Activity.getActivityText(activityType: activityType),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 24.0)
    ];

    this.activityDetails.forEach(
      (activityDetail) {
        widgets.add(
          Text(
            activityDetail.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        );

        if (activityDetail is ActivityDetailDateTime) {
          widgets.add(
            Text(
              '${DateFormat.jm(Localizations.localeOf(context).languageCode).format(activityDetail.dateTime)}',
              textAlign: TextAlign.center,
            ),
          );
          widgets.add(SizedBox(height: 24.0));
        }

        if (activityDetail is ActivityDetailOpenQuestion) {
          widgets.add(
            Text(
              activityDetail.value ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          );
          widgets.add(SizedBox(height: 24.0));
        }

        if (activityDetail is ActivityDetailValues) {
          widgets.add(
            Text(
              activityDetail.selectedValue ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          );
          widgets.add(SizedBox(height: 24.0));
        }
      },
    );

    widgets.add(
      Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: FlatButton(
                child: Text("Cerrar"),
                textColor: Theme.of(context).primaryColor,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
    );

    return ListView.builder(
      itemBuilder: (context, index) {
        return widgets[index];
      },
      itemCount: widgets.length,
      shrinkWrap: true,
    );
  }
}
