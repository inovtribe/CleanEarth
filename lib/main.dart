import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  List<LatLng> _points = [];
  List<Marker> mymarkers = <Marker>[
    new Marker(markerId: MarkerId('1'), position: _kGooglePlex.target)
  ];

  Set<Polyline> _drawAreaPolygon = new Set.from([]);

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
          polylines: _drawAreaPolygon,
          markers: Set<Marker>.from(mymarkers),
        ),
        Container(
          child: Icon(Icons.pin_drop),
        )
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _resetDrawArea,
        label: Text('Reset'),
        icon: Icon(Icons.refresh),
      ),
    );
  }

  Future<void> _resetDrawArea() async {
    setState(() {
      _points.add(_points[0]);
    });
    _points = [];
  }

  void _createCleanupArea(CameraPosition position) {
    _points.add(position.target);
    setState(() {
      _drawAreaPolygon.add(Polyline(
        polylineId: PolylineId("1"),
        width: 3,
        color: Colors.amber,
        // fillColor: Color.fromRGBO(0, 66, 42, 0.3),
        points: _points,
      ));
    });
  }
}
