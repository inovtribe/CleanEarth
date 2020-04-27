import 'package:flutter/material.dart';
import 'package:timwan/models/cleanup_event.dart';

class CleanupEventTile extends StatelessWidget {
  final CleanupEvent event;

  const CleanupEventTile({
    Key key,
    this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(event.title),
            subtitle: Text(event.description),
          )
        ],
      ),
    );
  }
}