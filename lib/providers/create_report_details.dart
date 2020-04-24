import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';
import 'package:timwan/models/trash_report.dart';
import 'package:timwan/utils/location.dart';
import 'package:timwan/widgets/create_report_start.dart';
import 'package:uuid/uuid.dart';

class CreateReportDetails with ChangeNotifier {
  File image;
  TrashReport report;
  List<TrashTag> tags = [];
  StorageUploadTask task;

  void updateImage(File _image) async {
    image = _image;
    notifyListeners();
  }

  Future<String> uploadImage() async {
    final path = 'images/${Uuid().v1()}.jpg';
    final ref = FirebaseStorage().ref().child(path);
    task = ref.putFile(image);
    print('image upload started');

    var url = await (await task.onComplete).ref.getDownloadURL();
    return url.toString();
  }

  void submitReport() async {
    print('create report submit started');
    if (image == null) {
      print('image not selected!');
      return;
    }

    // get user location to tag the report
    LocationData location = await getUserLocation();
    GeoFirePoint position = GeoFirePoint(location.latitude, location.longitude);

    // upload file & get download url
    String photoUrl = await uploadImage();
    print('got image download url');

    // save report into firebase
    final auth = FirebaseAuth.instance;
    final userId = (await auth.currentUser()).uid;
    report = TrashReport(
      active: false,
      position: position,
      photoUrl: photoUrl,
      userId: userId ?? "",
      tags: tags.map((tag) => tag.name).toList(),
      timestamp: DateTime.now().toUtc(),
    );
    
    Firestore _firestore = Firestore.instance;
    _firestore.collection('reports').add(report.toJson());
    print('added report to firestore');
  }
}
