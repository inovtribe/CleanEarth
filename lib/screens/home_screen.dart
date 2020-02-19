import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:timwan/models/main_app_state.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  MainAppState _appState = MainAppState.StartState;

  Set<Polyline> _polylines = new Set.from([]);
  List<LatLng> _points = [];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: Drawer(
        child: Center(
          child: Text("Drawer"),
        ),
      ),
      body: Stack(children: <Widget>[
        GoogleMap(
          mapType: MapType.terrain,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          myLocationButtonEnabled: false,
          onCameraMove: _createCleanupArea,
          polylines: _polylines,
        ),
        Builder(
          builder: (context) => Positioned(
            left: 10,
            top: 20,
            child: IconButton(
              icon: Icon(
                Icons.menu,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        _buildFloatingActionButtons(true, () {
          setState(() {
            _appState = MainAppState.CreateEventState;
          });
        }),
        _buildFloatingActionButtons(false, () {
          setState(() {
            _appState = MainAppState.CreateReportState;
          });
        }),
        Center(
          child: Icon(
            Icons.pin_drop,
            color: Colors.greenAccent,
            size: 40,
          ),
        )
      ]),
    );
  }

  void _createCleanupArea(CameraPosition position) {
    if (_appState == MainAppState.CreateEventState) {
      _points.add(position.target);
      setState(() {
        _polylines.add(Polyline(
          polylineId: PolylineId("1"),
          width: 3,
          color: Colors.amberAccent,
          points: _points,
        ));
      });
    }
  }

  Widget _buildFloatingActionButtons(bool isLeft, Function onTap) {
    if (_appState != MainAppState.StartState) return Container();

    return Container(
        padding: EdgeInsets.all(10),
        child: Align(
          alignment: isLeft ? Alignment.bottomLeft : Alignment.bottomRight,
          child: FloatingActionButton(
            child: isLeft ? Icon(Icons.event) : Icon(Icons.report),
            onPressed: onTap,
          ),
        ));
  }
}
