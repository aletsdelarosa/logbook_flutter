import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:log_book/HistoryScreen.dart';
import 'package:log_book/Widgets/ActivityInfoDialog.dart';
import 'package:log_book/Widgets/MessagesWidgets/CurrentDayEmpty.dart';
import 'package:log_book/models/Activity.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        title: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                  text: 'Bitácora',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20)),
              TextSpan(text: "\n"),
              TextSpan(
                  text: '${DateFormat.yMMMMEEEEd().format(DateTime.now())}',
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      fontSize: 16))
            ])),
        actions: <Widget>[
          IconButton(
              padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
              icon: Icon(Icons.history, color: Colors.white, size: 34),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryScreen())))
        ],
      ),
      body: Row(children: [Expanded(child: CurrentDayEmptyMessage())]),
      floatingActionButton: buildSpeedDial(),
    );
  }

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      backgroundColor: Colors.teal[800],
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      onOpen: () => null,
      onClose: () => null,
      visible: true,
      curve: Curves.bounceIn,
      children: ActivityType.values.map((activityType) {
        return SpeedDialChild(
          child: Icon(Activity.getActivityIcon(activityType: activityType), color: Colors.white),
          backgroundColor: Colors.tealAccent[700],
          onTap: () => showDialog(context: context, builder: (BuildContext context) => ActivityInfoDialog(activityType: activityType)),
          label: Activity.getActivityText(activityType: activityType),
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.tealAccent[700],
        );
      }).toList()
    );
  }
}
