import 'package:flutter/material.dart';
import 'package:timwan/models/cleanup_event.dart';

class CleanupEventTile extends StatelessWidget {
  final CleanupEvent event;
  final Function onTap;

  const CleanupEventTile({
    Key key,
    @required this.event,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(event.title),
              subtitle: Text(event.description),
            )
          ],
        ),
      ),
    );
  }
}
