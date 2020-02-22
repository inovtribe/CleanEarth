import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum MainAppState { StartState, CreateEventState, CreateReportState }
enum CreateEventState { DrawState, PauseState }

class MainAppDetails with ChangeNotifier {
  Set<Polyline> _polylines = new Set();
  List<LatLng> _points = [];

  // for app ui state
  MainAppState _appState = MainAppState.StartState;
  CreateEventState _createEventState = CreateEventState.DrawState;

  MainAppState get appState => _appState;
  CreateEventState get createEventState => _createEventState;

  set appState(MainAppState state) {
    _appState = state;
    notifyListeners();
  }

  Set<Polyline> get polylines => _polylines;

  void addPoint(LatLng point) {
    if (_appState != MainAppState.CreateEventState ||
        _createEventState != CreateEventState.DrawState) return;

    _points.add(point);
    _polylines.add(Polyline(
      polylineId: PolylineId("1"),
      width: 3,
      color: Colors.amberAccent,
      points: _points,
    ));

    notifyListeners();
  }

  void clearPoints() {
    _points.clear();
    notifyListeners();
  }

  // toggle between drawing polylines and pausing
  void toggleDrawState() {
    if (createEventState == CreateEventState.DrawState) {
      _createEventState = CreateEventState.PauseState;
    } else {
      _createEventState = CreateEventState.DrawState;
    }

    notifyListeners();
  }
}
