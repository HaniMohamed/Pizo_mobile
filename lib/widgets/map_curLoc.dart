import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:location/location.dart';

class MapLocation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MapLocation();
  }
}

class _MapLocation extends State<MapLocation> {
  Completer<GoogleMapController> _controller = Completer();
  Location _locationService = new Location();
  bool _permission = false;
  String error;
  bool currentWidget = true;
  LocationData _startLocation;
  BitmapDescriptor _markerIcon;
  LocationData location;
  final Set<Marker> _markers = {};

  @override
  initState() {
    super.initState();
    getCurLocation();
  }

  getCurLocation() async {
    await _locationService.changeSettings(
        accuracy: LocationAccuracy.HIGH, interval: 1000);

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        print("Permission: $_permission");
        if (_permission) {
          location = await _locationService.getLocation();
          final GoogleMapController controller = await _controller.future;

          setState(() {
            _startLocation = location;
            controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(location.latitude, location.longitude),
                    zoom: 16)));
          });
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if (serviceStatusResult) {
          getCurLocation();
        }
      }
    } catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
      location = null;
    }
  }

  static final CameraPosition _initMapPos = CameraPosition(
    target: LatLng(0, 0),
    zoom: 6,
  );

  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 180,
          width: double.infinity,
          child: GoogleMap(
            
            mapType: MapType.hybrid,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            initialCameraPosition: _initMapPos,
            onCameraMove: _onCameraMove,
            markers: _markers,
            myLocationEnabled: true,
          ),
        ),

      ],
    );
  }

  LatLng _lastMapPosition;
  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Location',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }
}
