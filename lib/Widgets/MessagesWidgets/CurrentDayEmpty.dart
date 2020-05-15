import 'package:flutter/material.dart';

class CurrentDayEmptyMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/list.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "No hay nada en tu bitácora",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Agrega una actividad realizada en el botón de abajo.",
                  textAlign: TextAlign.center,
                ),
              ],
            ));
  }
}
