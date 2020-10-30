import 'package:geolocator/geolocator.dart';

class LocationService {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _position;
  String locality;

  LocationService._privateConstructor();
  static final LocationService instance = LocationService._privateConstructor();

  get getLocationLat {
    double lat = instance._position.latitude;
    print('Lat: $lat');
    if (instance._position != null) {
      return instance._position.latitude;
    } else {
      return null;
    }
  }

  get getLocationLong {
    double long = instance._position.longitude;
    print('Long: $long');
    if (instance._position != null) {
      return instance._position.longitude;
    } else {
      return null;
    }
  }

  get getLocality {
    return instance.locality;
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
    if (distance < 500) {
      return 500;
    } else if (distance < 1000) {
      return 1000;
    } else if (distance < 5000) {
      return 5000;
    }
    return distance.round();
  }
}
