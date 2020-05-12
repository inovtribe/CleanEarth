import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:timwan/ui/widgets/cleanup_event_tile.dart';
import 'package:timwan/ui/widgets/reports_stats_card.dart';
import 'package:timwan/viewmodels/dashboard_view_model.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: ViewModelBuilder<DashboardViewModel>.reactive(
        viewModelBuilder: () => DashboardViewModel(),
        onModelReady: (model) async {
          await model.listenToNearbyReportsStats();
          await model.listenToNearbyEvents();
        },
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: ListView(
              padding: const EdgeInsets.only(
                top: 30,
                left: 30,
                right: 30,
              ),
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.person),
                        onPressed: model.navigateToUserDetails,
                      )
                    ],
                  ),
                ),
                Text(
                  'Nearby Reports',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ReportsStatsCard(
                  stats: model.stats,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Nearby Events',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                if (model.events != null && model.events.length > 0)
                  Container(
                    height: 250,
                    child: ListView.builder(
                      itemCount: model.events?.length ?? 0,
                      scrollDirection: Axis.horizontal,
                      itemExtent: 300,
                      itemBuilder: (context, index) {
                        return CleanupEventTile(
                          event: model.events[index],
                          onTap: () =>
                              model.navigateToEventDetails(model.events[index]),
                        );
                      },
                    ),
                  ),
                if (model.events == null || model.events.length == 0)
                  Container(
                    child: Text('No nearby cleanup events found :('),
                  ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: model.navigateToCreateReport,
              child: Icon(Icons.camera_alt),
            ),
          );
        },
      ),
    );
  }
}
