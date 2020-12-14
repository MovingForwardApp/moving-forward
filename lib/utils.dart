getFormatedDistance(int distance) {
  if (distance < 500) {
    /* Exact distance. Example: 123 m */
    return "$distance m";
  } else if (distance > 500 && distance < 2000) {
    /* From 100 to 100. Example: 1500 m */
    var roundDistance = (distance ~/ 100) * 100 + 100;
    return "$roundDistance m";
  } else if (distance > 2000) {
    /* In km. Example: 527 km */
    var roundDistance = (distance ~/ 100) * 100 + 100;
    var distanceInKm = (roundDistance / 1000);
    return "$distanceInKm km";
  }
}
