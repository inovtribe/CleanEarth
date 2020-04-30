import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:timwan/models/cleanup_event.dart';
import 'package:timwan/models/reports_stats.dart';
import 'package:timwan/models/trash_report.dart';
import 'package:timwan/models/user.dart';

class FirestoreService {
  final CollectionReference _usersCollectionRef =
      Firestore.instance.collection('users');
  final CollectionReference _eventsCollectionRef =
      Firestore.instance.collection('events');
  final CollectionReference _reportsCollectionRef =
      Firestore.instance.collection('reports');

  Geoflutterfire geo = Geoflutterfire();

  /// key in document snapshot where location data is stored
  String field = 'position';

  final StreamController<ReportsStats> _nearbyReportsStatsController =
      StreamController<ReportsStats>.broadcast();

  final StreamController<List<CleanupEvent>> _nearbyEventsController =
      StreamController<List<CleanupEvent>>.broadcast();

  Future createEvent(CleanupEvent event) async {
    try {
      await _eventsCollectionRef.add(event.toJson());
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future createReport(TrashReport report) async {
    try {
      await _reportsCollectionRef.add(report.toJson());
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Stream listenToNearbyEvents({
    @required GeoFirePoint point,
    double radius = 50.0,
  }) {
    try {
      geo
          .collection(collectionRef: _eventsCollectionRef)
          .within(center: point, radius: radius, field: field)
          .listen((snapshot) {
        var events = snapshot
            .map((document) => CleanupEvent.fromJson(document.data))
            .toList();

        _nearbyEventsController.add(events);
      });
    } catch (e) {
      print(e.toString());
    }

    return _nearbyEventsController.stream;
  }

  Stream listenToNearbyReportsStats({
    @required GeoFirePoint point,
    double radius = 25.0,
  }) {
    try {
      geo
          .collection(collectionRef: _reportsCollectionRef)
          .within(
            center: point,
            radius: radius,
            field: field,
            strictMode: true,
          )
          .listen((snapshot) {
        if (snapshot.isNotEmpty) {
          var reports =
              snapshot.map((document) => TrashReport.fromJson(document.data));

          var stats = ReportsStats();
          for (var report in reports) {
            if (report.active) {
              stats.needHelp += 1;
            } else {
              stats.cleanedUp += 1;
            }
          }

          _nearbyReportsStatsController.add(stats);
        }
      });
    } catch (e) {
      print(e.toString());
    }

    return _nearbyReportsStatsController.stream;
  }

  Future createUser(User user) async {
    try {
      await _usersCollectionRef.document(user.uid).setData(user.toJson());
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await _usersCollectionRef.document(uid).get();
      return User.fromData(userData.data);
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }
}
