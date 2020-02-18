import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  Set<Polyline> _drawAreaPolyline = new Set.from([]);
  List<LatLng> _points = [];

  bool _enableDraw = false;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(children: <Widget>[
        GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          onCameraMove: _createCleanupArea,
          polylines: _drawAreaPolyline,
        ),
        Center(
          child: Icon(
            Icons.pin_drop,
            color: Colors.greenAccent,
            size: 40,
          ),
        )
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            title: Text('Create Event'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.refresh),
            title: Text('Reset'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightBlueAccent,
        onTap: _onItemTapped,
      ),
    );
  }

  Future<void> _resetDrawArea() async {
    setState(() {
      // _points.add(_points[0]);
      _points.removeRange(0, _points.length);
    });
  }

  void _createCleanupArea(CameraPosition position) {
    if (_enableDraw) {
      _points.add(position.target);
      setState(() {
        _drawAreaPolyline.add(Polyline(
          polylineId: PolylineId("1"),
          width: 3,
          color: Colors.amberAccent,
          // fillColor: Color.fromRGBO(0, 66, 42, 0.3),
          points: _points,
        ));
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 2) _resetDrawArea();
      if (index == 1) _createEvent();
    });
  }

  void _createEvent() {
    _enableDraw = !_enableDraw;
  }
}
