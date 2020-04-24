import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:timwan/models/trash_report.dart';
import 'package:timwan/widgets/create_report_start.dart';

class CreateReportDetails with ChangeNotifier {
  File image;
  TrashReport report;
  List<TrashTag> tags = [];

  void updateImage(File _image) async {
    image = _image;
    notifyListeners();
  }

  void submitReport() async {
    print('create report submit started');
  }
}