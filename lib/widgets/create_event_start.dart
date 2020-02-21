import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timwan/models/main_event_details.dart';

class CreateEventStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mainAppDetails = Provider.of<MainAppDetails>(context);

    return Container(
        child: Center(
      child: Icon(
        Icons.pin_drop,
        color: Colors.green,
        size: 40,
      ),
    ));
  }
}
