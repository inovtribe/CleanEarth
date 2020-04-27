import 'dart:async';

import 'package:timwan/locator.dart';
import 'package:timwan/models/cleanup_event.dart';
import 'package:timwan/models/reports_stats.dart';
import 'package:timwan/services/firestore_service.dart';
import 'package:timwan/services/location_service.dart';
import 'package:timwan/viewmodels/base_model.dart';

class DashboardViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final LocationService _locationService = locator<LocationService>();

  ReportsStats _stats = ReportsStats();
  ReportsStats get stats => _stats;

  List<CleanupEvent> _events;
  List<CleanupEvent> get events => _events;

  StreamSubscription _statsStreamSubscription;
  StreamSubscription _eventsStreamSubscription;

  Future listenToNearbyReportsStats() async {
    setIsLoading(true);
    setErrors("");

    var position = await _locationService.getUserLocation();
    _statsStreamSubscription = _firestoreService
        .listenToNearbyReportsStats(point: position)
        .listen((stats) {
      ReportsStats newstats = stats;
      if (newstats != null) {
        _stats = newstats;
      }

      setIsLoading(false);
    });
  }

  Future listenToNearbyEvents() async {
    setIsLoading(true);
    setErrors("");

    var position = await _locationService.getUserLocation();
    _eventsStreamSubscription = _firestoreService
        .listenToNearbyEvents(point: position)
        .listen((events) {
      List<CleanupEvent> newEvents = events;
      if (newEvents != null && newEvents.length > 0) {
        _events = newEvents;
      }

      setIsLoading(false);
    });
  }

  @override
  void dispose() {
    _eventsStreamSubscription.cancel();
    _statsStreamSubscription.cancel();
    super.dispose();
  }
}
