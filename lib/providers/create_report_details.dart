import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:timwan/models/trash_report.dart';

class CreateReportDetails with ChangeNotifier {
  File image;
  TrashReport report;

  void updateImage(File _image) async {
    image = _image;
    notifyListeners();
  }
}