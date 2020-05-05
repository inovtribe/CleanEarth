import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:timwan/models/cleanup_event.dart';
import 'package:timwan/viewmodels/event_details_view_model.dart';

class EventDetailsScreen extends StatelessWidget {
  final CleanupEvent event;

  const EventDetailsScreen({
    Key key,
    @required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => EventDetailsViewModel(),
      builder: (context, model, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  event.title,
                  style: TextStyle(fontSize: 28),
                ),
                Text(
                  event.description,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
