import 'package:flutter/material.dart';

class CreateEventDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 60.0),
      padding: EdgeInsets.all(25.0),
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Event Name'),
          )
        ],
      ),
    );
  }
}
