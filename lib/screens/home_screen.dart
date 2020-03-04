import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timwan/providers/main_event_details.dart';
import 'package:timwan/widgets/create_event_start.dart';

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

  @override
  Widget build(BuildContext context) {
    final mainAppDetails = Provider.of<MainAppDetails>(context);

    return new Scaffold(
      body: Stack(children: <Widget>[
        GoogleMap(
          mapType: MapType.terrain,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          myLocationButtonEnabled: false,
          onCameraMove: (position) => mainAppDetails.addPoint(position.target),
          polylines: mainAppDetails.polylines,
        ),
        _buildBottomSheet(mainAppDetails),
      ]),
    );
  }

  Widget _buildBottomSheet(MainAppDetails appDetails) {
    if (appDetails.appState == MainAppState.CreateEventState) {
      return CreateEventStart();
    } else if (appDetails.appState == MainAppState.CreateReportState) {
      return Container();
    }

    return SpeedDial(
      marginRight: 25,
      marginBottom: 30,
      animatedIcon: AnimatedIcons.menu_close,
      children: [
        SpeedDialChild(
            child: Icon(Icons.event),
            label: 'Create a Event',
            onTap: () {
              appDetails.appState = MainAppState.CreateEventState;
            }),
        SpeedDialChild(
            child: Icon(Icons.report),
            label: 'Create a Report',
            onTap: () => print("Creating a report")),
      ],
    );
  }
}
