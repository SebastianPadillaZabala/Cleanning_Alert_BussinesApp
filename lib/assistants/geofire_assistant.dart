import '../models/active_nearby_available_drivers.dart';

class GeoFireAssistants {
  static List<ActiveNearbyAvailableDrivers> activeNearbyAvailableDriverList =
      [];

  static void deleteOffLineDriverFromList(String driverId) {
    int indexNumber = activeNearbyAvailableDriverList
        .indexWhere((element) => element.driverId == driverId);
    activeNearbyAvailableDriverList.removeAt(indexNumber);
  }

  static void updateActiveNearbyAvailableDriverLocation(
      ActiveNearbyAvailableDrivers driverWhoMove) {
    int indexNumber = activeNearbyAvailableDriverList
        .indexWhere((element) => element.driverId == driverWhoMove.driverId);
    activeNearbyAvailableDriverList[indexNumber].locationLatitude =
        driverWhoMove.locationLatitude;
    activeNearbyAvailableDriverList[indexNumber].locationLongitude =
        driverWhoMove.locationLongitude;
  }
}
