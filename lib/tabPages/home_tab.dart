import 'dart:async';

import 'package:cleanning_alert_bussines/assistants/assistants_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../assistants/geofire_assistant.dart';
import '../models/active_nearby_available_drivers.dart';

class HomeTabPage extends StatefulWidget {
  HomeTabPage({Key? key}) : super(key: key);

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  GoogleMapController? newGoogleMapController;
  final Completer<GoogleMapController> _controllerGoogleMap =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Position? userCurrentPosition;
  var geoLocator = Geolocator();

  LocationPermission? _locationPermission;
  bool activeNearbyDriversKeysLoaded = false;
  Set<Marker> markerSet = {};
  Set<Circle> circleSet = {};
  BitmapDescriptor? activeNearbyIcon;
  List<ActiveNearbyAvailableDrivers> onlineNearByAvailableDriversList = [];

  checkIfLocationPermissionAllowed() async {
    _locationPermission = await Geolocator.requestPermission();

    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
    }
  }

  locateUserPosition() async {
    Position cPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    userCurrentPosition = cPosition;

    LatLng LatLngPosition =
        LatLng(userCurrentPosition!.latitude, userCurrentPosition!.longitude);
    CameraPosition cameraPosition =
        CameraPosition(target: LatLngPosition, zoom: 14);
    newGoogleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    String humanReadableAddress =
        await AssistantMethods.searchAddressForGeographicsCoordinates(
            userCurrentPosition!, context);

    print(humanReadableAddress);

    intializeGeoFireListener();
  }

  @override
  void initState() {
    super.initState();
    // AssistantMethods.readCurrentOnlineUserInfo();
    checkIfLocationPermissionAllowed();
  }

  @override
  Widget build(BuildContext context) {
    createActiveNearByDriverIconMaker();
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          zoomGesturesEnabled: true,
          markers: markerSet,
          circles: circleSet,
          zoomControlsEnabled: true,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controllerGoogleMap.complete(controller);
            newGoogleMapController = controller;
            locateUserPosition();
          },
        ),
      ],
    );
  }

  intializeGeoFireListener() {
    Geofire.initialize('activeDrivers');
    Geofire.queryAtLocation(
            userCurrentPosition!.latitude, userCurrentPosition!.longitude, 300)!
        .listen((map) {
      print(map);
      if (map != null) {
        var callBack = map['callBack'];

        //latitude will be retrieved from map['latitude']
        //longitude will be retrieved from map['longitude']

        switch (callBack) {
          case Geofire.onKeyEntered: //cuando se pone online un driver
            ActiveNearbyAvailableDrivers activeNearbyAvailableDriver =
                ActiveNearbyAvailableDrivers();
            activeNearbyAvailableDriver.locationLatitude = map['latitude'];
            activeNearbyAvailableDriver.locationLongitude = map['longitude'];
            activeNearbyAvailableDriver.driverId = map['key'];
            GeoFireAssistants.activeNearbyAvailableDriverList
                .add(activeNearbyAvailableDriver);
            if (activeNearbyDriversKeysLoaded == true) {
              displayActiveDriverOnUserMap();
            }
            break;

          case Geofire.onKeyExited: //cuando se pone offline un driver
            GeoFireAssistants.deleteOffLineDriverFromList(map['key']);
            displayActiveDriverOnUserMap();
            break;

          case Geofire
              .onKeyMoved: //cuando el driver se mueve - actualizar ubicacion
            ActiveNearbyAvailableDrivers activeNearbyAvailableDriver =
                ActiveNearbyAvailableDrivers();
            activeNearbyAvailableDriver.locationLatitude = map['latitude'];
            activeNearbyAvailableDriver.locationLongitude = map['longitude'];
            activeNearbyAvailableDriver.driverId = map['key'];
            GeoFireAssistants.updateActiveNearbyAvailableDriverLocation(
                activeNearbyAvailableDriver);
            displayActiveDriverOnUserMap();
            break;

          case Geofire.onGeoQueryReady: //mostrar conductores activos/enlinea
            activeNearbyDriversKeysLoaded = true;
            displayActiveDriverOnUserMap();
            break;
        }
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  displayActiveDriverOnUserMap() {
    if (mounted) {
      setState(() {
        markerSet.clear();
        circleSet.clear();

        Set<Marker> driverMarkerSet = Set<Marker>();

        for (ActiveNearbyAvailableDrivers eachDriver
            in GeoFireAssistants.activeNearbyAvailableDriverList) {
          LatLng eachDriverActivePosition = LatLng(
              eachDriver.locationLatitude!, eachDriver.locationLongitude!);

          Marker marker = Marker(
              markerId: MarkerId(eachDriver.driverId!),
              position: eachDriverActivePosition,
              icon: activeNearbyIcon!,
              rotation: 360);
          driverMarkerSet.add(marker);
        }
        setState(() {
          markerSet = driverMarkerSet;
        });
      });
    }
  }

  createActiveNearByDriverIconMaker() {
    if (activeNearbyIcon == null) {
      ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: const Size(2, 2));
      BitmapDescriptor.fromAssetImage(imageConfiguration, 'images/car.png')
          .then((value) {
        activeNearbyIcon = value;
      });
    }
  }
}
