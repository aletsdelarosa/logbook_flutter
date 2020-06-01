import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:log_book/HistoryScreen.dart';
import 'package:log_book/Widgets/ActivityInfoDialog.dart';
import 'package:log_book/Widgets/ActivityRow.dart';
import 'package:log_book/Widgets/AddActivityDialog.dart';
import 'package:log_book/Widgets/MessagesWidgets/CurrentDayEmpty.dart';
import 'package:log_book/models/Activity.dart';
import 'package:log_book/models/Log.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
      floatingActionButton: _buildSpeedDial(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.teal[400],
      title: RichText(
        textAlign: Platform.isIOS ? TextAlign.center : TextAlign.left,
        text: TextSpan(children: [
          TextSpan(
            text: 'Bitácora diaria',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          TextSpan(text: "\n"),
          TextSpan(
            text:
                '${DateFormat.yMMMMEEEEd(Localizations.localeOf(context).languageCode).format(DateTime.now())}',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ]),
      ),
      actions: <Widget>[
        IconButton(
          padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
          icon: Icon(Icons.history, color: Colors.white, size: 34),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HistoryScreen()),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return FutureBuilder(
      future: Logs.instance.getTodaysLogs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        }
        List<Log> logs = snapshot.data;
        if (logs == null || logs.isEmpty) {
          return Row(
            children: [
              Expanded(child: CurrentDayEmptyMessage()),
            ],
          );
        }

        return ListView.separated(
          itemBuilder: (context, index) {
            return GestureDetector(
              child: ActivityRow(log: logs[index]),
              onTap: () => showDialog(
                context: context,
                builder: (BuildContext context) =>
                    ActivityInfoDialog(log: logs[index]),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: logs.length,
        );
      },
    );
  }

  SpeedDial _buildSpeedDial() {
    return SpeedDial(
      backgroundColor: Colors.teal[800],
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      onOpen: () => null,
      onClose: () => null,
      visible: true,
      curve: Curves.bounceIn,
      children: ActivityType.values.reversed.map((activityType) {
        return SpeedDialChild(
          child: Icon(
            Activity.getActivityIcon(activityType: activityType),
            color: Colors.white,
          ),
          backgroundColor: Colors.tealAccent[700],
          onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) =>
                AddActivityDialog(activityType: activityType),
          ).then(
            (created) {
              if (created) {
                setState(() {});
              }
            },
          ),
          label: Activity.getActivityText(activityType: activityType),
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.tealAccent[700],
        );
      }).toList(),
    );
  }
}
