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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nearby Reports',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          // margin: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                height: 100,
                width: 150,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        stats.cleaned?.toString() ?? '0',
                        style: TextStyle(fontSize: 24),
                      ),
                      Text('need help'),
                    ],
                  ),
                ),
              ),
              Container(
                height: 100,
                width: 150,
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        stats.reported?.toString() ?? '0',
                        style: TextStyle(fontSize: 24),
                      ),
                      Text('cleaned up')
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
