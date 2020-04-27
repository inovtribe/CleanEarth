import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:timwan/ui/widgets/cleanup_event_tile.dart';
import 'package:timwan/ui/widgets/reports_stats_card.dart';
import 'package:timwan/viewmodels/dashboard_view_model.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      viewModelBuilder: () => DashboardViewModel(),
      onModelReady: (model) async {
        await model.listenToNearbyReportsStats();
        await model.listenToNearbyEvents();
      },
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.only(
              top: 30.0,
              left: 10.0,
              right: 10.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.person),
                        // TODO: create user page
                        onPressed: model.signOut,
                      )
                    ],
                  ),
                ),
                ReportsStatsCard(
                  stats: model.stats,
                ),
                Container(
                  height: 250,
                  child: ListView.builder(
                    itemCount: model.events?.length ?? 0,
                    scrollDirection: Axis.horizontal,
                    itemExtent: 300,
                    itemBuilder: (context, index) {
                      return CleanupEventTile(
                        event: model.events[index],
                      );
                    },
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
