import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
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

  Future<Position> _getCurrentPosition() async {
    /* NOTE: If we want no ask about location if is disable in the device.
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("EE Location services are disabled.");
      return Future.error("Location services are disabled.");
    }
     */

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      print("EE Location permissions are permantly denied, we cannot request permissions.");
      return Future.error("Location permissions are permantly denied, we cannot request permissions.");
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        print("EE Location permissions are denied (actual value: $permission).");
        return Future.error("Location permissions are denied (actual value: $permission).");
      }
    }

    return Geolocator.getCurrentPosition();
  }

  Future<String> fetchCurrentLocality() async {
    if (instance._position == null) {
      instance._position =  await _getCurrentPosition();
      print("Geolocate at ${instance._position}");
    }

    List<Placemark> p = await placemarkFromCoordinates(
        instance.locationLat, instance.locationLong);

    Placemark place = p[0];

    instance.locality = "${place.locality}";

    return instance.locality;
  }

  Future<int> getDistance(double endLatitude, double endLongitude) async {
    if (instance._position == null) {
      await _getCurrentPosition();
    }

    final double distance = Geolocator.distanceBetween(
        instance.locationLat,
        instance.locationLong,
        endLatitude,
        endLongitude);

    return distance.round();
  }
}
