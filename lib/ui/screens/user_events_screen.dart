import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:timwan/models/cleanup_event.dart';
import 'package:timwan/viewmodels/user_events_view_model.dart';

class UserEventsScreen extends StatelessWidget {
  final tabs = <Tab>[
    Tab(
      text: 'Created',
      icon: Icon(Icons.create),
    ),
    Tab(
      text: 'Volunteered',
      icon: Icon(Icons.pan_tool),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserEventsViewModel>.reactive(
      viewModelBuilder: () => UserEventsViewModel(),
      onModelReady: (model) => model.initilize(),
      builder: (context, model, _) {
        return DefaultTabController(
          length: tabs.length,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Events'),
              bottom: TabBar(
                tabs: tabs,
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                _buildListView(model.isLoading, model.createdEvents),
                _buildListView(model.isLoading, model.volunteeredEvents),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildListView(bool isLoading, List<CleanupEvent> events) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (events == null || events.isEmpty) {
      return Center(
        child: Text(':( You don\'t have any events'),
      );
    }

    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return Text('$index');
      },
    );
  }
}
