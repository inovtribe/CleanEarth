import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  static String _currentAddress;
  static double latitude;
  static double longitude;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_currentPosition != null) Text(_currentAddress),
            FlatButton(
              child: Text("Get location"),
              onPressed: () {
                _getCurrentLocation();
              },
            ),
          ],
        ),
      ),
    );
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        longitude = position.longitude;
        latitude = position.latitude;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
       Navigator.push(
                      context,
                       MaterialPageRoute(builder: (context) => new MapSample()
                        ));
    } catch (e) {
      print(e);
    }
  }
}



//AT THE TOP OF THIS CODE, LATITUDE AND LONGITUDE ARE CALCULATED
//NOW WE DISPLAY THAT IN THE MAP


class MapSample extends StatefulWidget {


  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

static double latty = _HomePageState.latitude;    // Latitude
static double longy = _HomePageState.longitude;   // Longitude
static String currentAddress = _HomePageState._currentAddress;

List <Marker> allMarkers = [];

@override
void initState(){
  super.initState();
  allMarkers.add(Marker(
    markerId: MarkerId('myMarker'),
    infoWindow: InfoWindow(
      title: currentAddress,
      snippet: 'Trash',
    ),
    
    draggable: false,
    onTap: () {  
      _showModalSheet();                   //Marker On Tap
      print('Marker Tapped');
    },
    position: LatLng(latty,longy)
  ));
}

 void _showModalSheet() {      //SHOW MODAL SHEET
    showModalBottomSheet(context: context, builder: (builder) {
      return Container(       
        child: Image.network('https://i.stack.imgur.com/ilEcY.png'), // Get Trash pic from database
        padding: EdgeInsets.all(40.0),
      );
    });
  }

  Completer<GoogleMapController> _controller = Completer();
  

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(latty, longy),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        markers: Set.from(allMarkers),
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          print ("lattitude is $latty");
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    print ("lattitude is $latty");
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}