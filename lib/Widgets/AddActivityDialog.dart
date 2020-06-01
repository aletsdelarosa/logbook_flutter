import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:log_book/models/Activity.dart';
import 'package:log_book/models/ActivityDetail.dart';
import 'package:log_book/models/ActivityDetails.dart';
import 'package:log_book/models/Log.dart';

class AddActivityDialog extends StatefulWidget {
  final ActivityType activityType;

  AddActivityDialog({@required this.activityType});

  @override
  _AddActivityDialogState createState() =>
      _AddActivityDialogState(activityType: this.activityType);
}

class _AddActivityDialogState extends State<AddActivityDialog> {
  final ActivityType activityType;
  DateTime date = DateTime.now();
  List<ActivityDetail> activityDetails;
  _AddActivityDialogState({@required this.activityType});

  @override
  void initState() {
    super.initState();
    this.activityDetails =
        ActivityDetails.getActivityDetails(activityType: this.activityType);
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
        //height: MediaQuery.of(context).size.height * 0.85,
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
                child: _buildListOfWidgets(activityType: activityType),
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
          activityDetail.dateTime = this.date;
          widgets.add(
            FlatButton(
              onPressed: () {
                showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(this.date),
                ).then(
                  (time) {
                    activityDetail.dateTime = DateTime(
                      this.date.year,
                      this.date.month,
                      this.date.day,
                      time.hour,
                      time.minute,
                    );

                    setState(() {
                      this.date = activityDetail.dateTime;
                    });
                  },
                );
              },
              child: Text(
                '${DateFormat.jm(Localizations.localeOf(context).languageCode).format(this.date)}',
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          );
          widgets.add(SizedBox(height: 24.0));
        }

        if (activityDetail is ActivityDetailOpenQuestion) {
          widgets.add(
            TextField(
              decoration: InputDecoration(
                labelText: activityDetail.placeholder,
                labelStyle: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              onChanged: (value) {
                activityDetail.value = value;
              },
            ),
          );
          widgets.add(SizedBox(height: 24.0));
        }

        if (activityDetail is ActivityDetailValues) {
          widgets.add(
            DropdownButton(
              hint: Text(
                activityDetail.hint,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.0),
              ),
              value: activityDetail.selectedValue,
              onChanged: (newValue) {
                activityDetail.selectedValue = newValue;
                setState(() {});
              },
              items: activityDetail.values.map(
                (value) {
                  return DropdownMenuItem(
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.0),
                    ),
                    value: value,
                  );
                },
              ).toList(),
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
                onPressed: () => Navigator.of(context).pop(false),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: FlatButton(
                child: Text("Agregar"),
                textColor: Theme.of(context).primaryColor,
                onPressed: () {
                  this._addActivity().then(
                    (_) => Navigator.of(context).pop(true),
                  );
                },
              ),
            ),
          )
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

  Future<void> _addActivity() {
    return Logs.instance.addLog(
      date: this.date,
      activityType: this.activityType,
      details: ActivityDetails(detailsInfo: this.activityDetails),
    );
  }
}
