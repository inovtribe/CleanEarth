import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';

class LocationService {
  GeoFirePoint _currentLocation;
  GeoFirePoint get currentLocation => _currentLocation;

  Location location = new Location();

  Future<GeoFirePoint> getUserLocation() async {
    try {
      LocationData _locationData = await location.getLocation();
      _currentLocation = GeoFirePoint(
        _locationData.latitude,
        _locationData.longitude,
      );
    } catch (e) {
      print('Could not get location: ${e.toString()}');
    }

    return _currentLocation;
  }
}
