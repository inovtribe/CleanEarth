import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:timwan/models/cleanup_event.dart';
import 'package:timwan/ui/widgets/reports_stats_card.dart';
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
      onModelReady: (model) async => model.initilize(event.uid),
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
          body: ListView(
            padding: const EdgeInsets.only(
              top: 30,
              left: 30,
              right: 30,
            ),
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
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '- ${event.owner.fullName}',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[800],
                ),
              ),
              ReportsStatsCard(
                stats: model.stats,
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: model.navigateToReportsMapScreen,
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                    left: 3,
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.arrow_forward),
                      Text('View Reports'),
                    ],
                  ),
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => model.onFabPressed(event.uid),
            label: Text(
              model.isUserPartOfEvent ? 'Create Report' : 'Volunteer',
            ),
          ),
        );
      },
    );
  }
}
