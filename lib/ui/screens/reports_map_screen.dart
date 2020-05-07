import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:timwan/models/trash_report.dart';

class ReportsMapScreen extends StatelessWidget {
  final List<TrashReport> reports;

  const ReportsMapScreen({
    Key key,
    this.reports,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LatLng _center = LatLng(30, 40);
    if (reports != null && reports.isNotEmpty) {
      _center = LatLng(
        reports.first.position.latitude,
        reports.first.position.longitude,
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // TODO: extend maps to top of screen
        title: Text(
          'Reports',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: GoogleMap(
        mapType: MapType.terrain,
        markers: _createMarkers(),
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 10,
        ),
      ),
    );
  }

  Set<Marker> _createMarkers() {
    return reports
        .map((e) => Marker(
            markerId: MarkerId(e.hashCode.toString()),
            infoWindow: InfoWindow(title: e.tags.toString()),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              e.cleanerUid == null || e.cleanerUid.isEmpty
                  ? BitmapDescriptor.hueRed
                  : BitmapDescriptor.hueGreen,
            ),
            position: LatLng(
              e.position.latitude,
              e.position.longitude,
            )))
        .toSet();
  }
}
