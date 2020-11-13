import 'package:geolocator/geolocator.dart';

class LocationService {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _position;
  String locality;

  LocationService._privateConstructor();
  static final LocationService instance = LocationService._privateConstructor();

  get locationLat {
    return instance._position != null
      ? instance._position.latitude
      : null;
  }

  get locationLong {
    return instance._position != null
      ? instance._position.longitude
      : null;
  }

  Future _getCurrentLocation() async {
    await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position currentPosition) {
      instance._position = currentPosition;
    });
  }

  Future<String> fetchCurrentLocality() async {
    await _getCurrentLocation();
    List<Placemark> p = await geolocator.placemarkFromCoordinates(
        instance._position.latitude, instance._position.longitude);

    Placemark place = p[0];

    instance.locality = "${place.locality}";

    return instance.locality;
  }

  Future<int> getDistance(double endLatitude, double endLongitude) async {
    await _getCurrentLocation();
    double distance = await Geolocator().distanceBetween(
        instance._position.latitude,
        instance._position.longitude,
        endLatitude,
        endLongitude);

    return distance.round();
  }
}
