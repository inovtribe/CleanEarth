import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:timwan/models/image_data.dart';

class TrashReport {
  GeoFirePoint position;
  ImageData imageData;
  String userId;
  List<String> tags;
  bool active;
  DateTime timestamp;

  TrashReport(
      {this.position,
      this.imageData,
      this.userId,
      this.tags,
      this.active,
      this.timestamp});

  TrashReport.fromJson(Map<String, dynamic> json) {
    if (json['position'] != null) {
      position = new GeoFirePoint(
        json['position']['geopoint'].latitude,
        json['position']['geopoint'].longitude,
      );
    } else {
      position = null;
    }
    imageData = ImageData.fromJson(json['image_data']);
    userId = json['user_id'];
    tags = json['tags'].cast<String>();
    active = json['active'];
    timestamp = (json['timestamp'] as Timestamp).toDate();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.position != null) {
      data['position'] = this.position.data;
    }
    data['image_data'] = this.imageData.toJson();
    data['user_id'] = this.userId;
    data['tags'] = this.tags;
    data['active'] = this.active;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
