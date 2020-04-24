import 'package:geoflutterfire/geoflutterfire.dart';

class TrashReport {
  GeoFirePoint position;
  String photoUrl;
  String userId;
  List<String> tags;
  bool active;
  DateTime timestamp;

  TrashReport(
      {this.position,
      this.photoUrl,
      this.userId,
      this.tags,
      this.active,
      this.timestamp});

  TrashReport.fromJson(Map<String, dynamic> json) {
    position = json['position'] != null
        ? new GeoFirePoint(json['position']['geopoint'].latitude, json['position'].longitude)
        : null;
    photoUrl = json['photo_url'];
    userId = json['user_id'];
    tags = json['tags'].cast<String>();
    active = json['active'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.position != null) {
      data['position'] = this.position.data;
    }
    data['photo_url'] = this.photoUrl;
    data['user_id'] = this.userId;
    data['tags'] = this.tags;
    data['active'] = this.active;
    data['timestamp'] = this.timestamp;
    return data;
  }
}