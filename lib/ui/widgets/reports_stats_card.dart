import 'package:flutter/material.dart';
import 'package:timwan/models/reports_stats.dart';

class ReportsStatsCard extends StatelessWidget {
  final ReportsStats stats;

  const ReportsStatsCard({
    Key key,
    @required this.stats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(stats.needHelp.toString()),
        Text(stats.cleanedUp.toString()),
      ],
    );
  }
}