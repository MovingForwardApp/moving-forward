import 'package:geolocator/geolocator.dart';

class LocationService {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _position;
  String locality;

  LocationService._privateConstructor();
  static final LocationService instance = LocationService._privateConstructor();

  get getLocality {
    if (locality != null) {
      return instance.locality;
    }
  }

  Future _getCurrentLocation() async {
    return await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position currentPosition) {
      instance._position = currentPosition;
    });
  }

  Future fetchCurrentLocality() async {
    await _getCurrentLocation();
    List<Placemark> p = await geolocator.placemarkFromCoordinates(
        instance._position.latitude, instance._position.longitude);

    Placemark place = p[0];

    instance.locality = "${place.locality}";
  }

  Future<double> getDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) async {
    // return await Geolocator().distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);
    return await Geolocator().distanceBetween(
        startLatitude, startLongitude, endLatitude, endLatitude);
  }
}
