import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:log_book/models/Activity.dart';

class ActivityInfoDialog extends StatelessWidget {
  final ActivityType activityType;

  ActivityInfoDialog({@required this.activityType});

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(Activity.getActivityText(activityType: activityType),
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Fecha:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '${DateFormat.yMMMMEEEEd().format(DateTime.now())}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Lugar:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Planta 1',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Row(
                children: <Widget>[
                  Expanded(
                    child: 
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: FlatButton(
                        child: Text("Cerrar"),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    )
                  ),
                  Expanded(
                    child: 
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: FlatButton(
                        child: Text("Agregar"),
                        textColor: Theme.of(context).primaryColor,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    )
                  )
                ]
            ),
          ],
        ),
      ),
    );
  }
}
