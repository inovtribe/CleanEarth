import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class CleanupEvent {
  String title;
  String description;
  String ownerUid;
  DateTime startTime;
  DateTime endTime;

  /// Center point of cleanup event.
  GeoFirePoint position;

  /// Radius of cleanup event from center position.
  int radius;

  /// List of volunteer(User) uid's.
  List<String> volunteers;

  /// List of organizers(User) uid's.
  List<String> organizers;

  /// List of reports uid's for this event.
  List<String> reports;

  CleanupEvent({
    @required this.title,
    this.description,
    @required this.ownerUid,
    this.startTime,
    this.endTime,
    @required this.position,
    @required this.radius,
    this.volunteers,
    this.organizers,
    this.reports,
  });

  CleanupEvent.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    ownerUid = json['owner_uid'];
    startTime = (json['start_time'] as Timestamp).toDate();
    endTime = (json['end_time'] as Timestamp).toDate();
    if (json['position'] != null) {
      position = new GeoFirePoint(
        json['position']['geopoint'].latitude,
        json['position']['geopoint'].longitude,
      );
    } else {
      position = null;
    }
    radius = json['radius'];
    volunteers = json['volunteers']?.cast<String>();
    organizers = json['organizers']?.cast<String>();
    reports = json['reports']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['owner_uid'] = this.ownerUid;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['position'] = this.position.data;
    data['radius'] = this.radius;
    data['volunteers'] = this.volunteers;
    data['organizers'] = this.organizers;
    data['reports'] = this.reports;
    return data;
  }
}
