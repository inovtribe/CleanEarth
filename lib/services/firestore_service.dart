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
  final CollectionReference _volunteersCollectionRef =
      Firestore.instance.collection('volunteers');

  Geoflutterfire geo = Geoflutterfire();

  /// key in document snapshot where location data is stored
  String field = 'position';

  StreamSubscription _nearbyReportsSubscription;
  final StreamController<ReportsStats> _nearbyReportsStatsController =
      StreamController<ReportsStats>.broadcast();

  StreamSubscription _nearbyEventsSubscription;
  final StreamController<List<CleanupEvent>> _nearbyEventsController =
      StreamController<List<CleanupEvent>>.broadcast();

  // This will hold the stream of reports of current selected event
  StreamSubscription _reportsFromEventSubscription;
  final StreamController<List<TrashReport>> _reportsFromEventController =
      StreamController<List<TrashReport>>.broadcast();

  // This will hold the stream of volunteers of current selected event
  StreamSubscription _volunteersFromEventSubscription;
  final StreamController<List<User>> _volunteersFromEventController =
      StreamController<List<User>>.broadcast();

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
      _nearbyEventsSubscription = geo
          .collection(collectionRef: _eventsCollectionRef)
          .within(center: point, radius: radius, field: field)
          .listen((snapshot) {
        var events = snapshot
            .map((document) => CleanupEvent.fromJson(
                  document.data,
                  document.documentID,
                ))
            .toList();

        _nearbyEventsController.add(events);
      });
    } catch (e) {
      print(e.toString());
    }

    return _nearbyEventsController.stream;
  }

  void cancelNearbyEventsSubscription() {
    _nearbyEventsSubscription.cancel();
  }

  Stream listenToNearbyReportsStats({
    @required GeoFirePoint point,
    double radius = 25.0,
  }) {
    try {
      _nearbyReportsSubscription = geo
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

          var stats = ReportsStats(
            cleaned: 0,
            reported: 0,
          );
          for (var report in reports) {
            if (report.cleanerUid != null) {
              stats.cleaned += 1;
            }
            stats.reported += 1;
          }

          _nearbyReportsStatsController.add(stats);
        }
      });
    } catch (e) {
      print(e.toString());
    }

    return _nearbyReportsStatsController.stream;
  }

  void cancelNearbyStatsSubscription() {
    _nearbyReportsSubscription.cancel();
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
      return User.fromJson(userData.data);
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future addUserToEvent({
    String eventUid,
    String userUid,
    String fullName,
  }) async {
    if (eventUid.isEmpty || userUid.isEmpty) {
      return;
    }

    try {
      await _volunteersCollectionRef.document('${eventUid}_$userUid').setData({
        'event_uid': eventUid,
        'user_uid': userUid,
        'full_name': fullName,
      });
    } catch (e) {
      return e.message;
    }
  }

  Stream listenToReportsFromEvent({
    String eventUid,
  }) {
    try {
      _reportsFromEventSubscription = _reportsCollectionRef
          .where(
            'event_uid',
            isEqualTo: eventUid,
          )
          .snapshots()
          .listen((snapshot) {
        var reports = snapshot.documents
            .map((doc) => TrashReport.fromJson(doc.data))
            .toList();

        _reportsFromEventController.add(reports);
      });
    } catch (e) {
      print(e.message);
    }

    return _reportsFromEventController.stream;
  }

  void cancelReportsFromEventSubscription() {
    _reportsFromEventSubscription.cancel();
  }

  Stream listenToVolunteersFromEvent({
    String eventUid,
  }) {
    try {
      _volunteersFromEventSubscription = _volunteersCollectionRef
          .where(
            'event_uid',
            isEqualTo: eventUid,
          )
          .snapshots()
          .listen((snapshot) {
        var users = snapshot.documents
            .map((e) => User(
                  uid: e.data['user_uid'],
                  fullName: e.data['full_name'],
                ))
            .toList();

        _volunteersFromEventController.add(users);
      });
    } catch (e) {
      print(e.message);
    }

    return _volunteersFromEventController.stream;
  }

  void cancelVolunteerssFromEventSubscription() {
    _volunteersFromEventSubscription.cancel();
  }

  Future isUserPartOfEvent({
    String eventUid,
    String userUid,
  }) async {
    try {
      var result =
          await _volunteersCollectionRef.document('${eventUid}_$userUid').get();

      // if "eventUid_userUid" exists
      // the user is part of the event
      return result.exists;
    } catch (e) {
      return e.message;
    }
  }
}
