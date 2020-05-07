import 'package:flutter/material.dart';
import 'package:timwan/models/trash_report.dart';

class ReportsMapScreen extends StatelessWidget {
  final List<TrashReport> reports;

  const ReportsMapScreen({
    Key key,
    this.reports,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(reports);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Container(),
    );
  }
}
