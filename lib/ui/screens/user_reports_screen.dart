import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:timwan/models/trash_report.dart';
import 'package:timwan/viewmodels/user_reports_view_model.dart';

class UserReportsScreen extends StatelessWidget {
  final tabs = <Tab>[
    Tab(
      text: 'Reported',
      icon: Icon(Icons.report),
    ),
    Tab(
      text: 'Cleaned',
      icon: Icon(Icons.done),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserReportsViewModel>.reactive(
      viewModelBuilder: () => UserReportsViewModel(),
      onModelReady: (model) => model.initilize(),
      builder: (context, model, _) {
        return DefaultTabController(
          length: tabs.length,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Reports'),
              bottom: TabBar(
                tabs: tabs,
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                _buildListView(model.isLoading, model.createdReports),
                _buildListView(model.isLoading, model.cleanedReports),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildListView(bool isLoading, List<TrashReport> reports) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (reports == null || reports.isEmpty) {
      return Center(
        child: Text(':( You don\'t have any reports'),
      );
    }

    return ListView.builder(
      itemCount: reports.length,
      itemBuilder: (context, index) {
        return Text(reports[index].tags.toString());
      },
    );
  }
}
