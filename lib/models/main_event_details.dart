import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum MainAppState { StartState, CreateEventState, CreateReportState }

class MainAppDetails with ChangeNotifier {
  Set<Polyline> _polylines = new Set();
  List<LatLng> _points = [];

  // for app ui state
  MainAppState _appState = MainAppState.StartState;
  MainAppState get appState => _appState;

  set appState(MainAppState state) {
    _appState = state;
    notifyListeners();
  }

  Set<Polyline> get polylines => _polylines;

  void addPoint(LatLng point) {
    if (_appState != MainAppState.CreateEventState) return;

    _points.add(point);
    _polylines.add(Polyline(
      polylineId: PolylineId("1"),
      width: 3,
      color: Colors.amberAccent,
      points: _points,
    ));

    notifyListeners();
  }
}
