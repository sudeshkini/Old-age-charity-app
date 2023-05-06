/*import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice_ex/places.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  static const routname = "/mapscreen";
  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng? _latLng = LatLng(28.6472799, 76.8130638);

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(28.6289206,77.2065322),
    zoom: 14.4746,
  );

  static final CameraPosition _eldersheaven = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(13.3346314, 77.1325076),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Future<void> getCurrentLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    _latLng = LatLng(_locationData.latitude!, _locationData.longitude!);
    print(_latLng);

    _kGooglePlex = CameraPosition(
      target: _latLng!,
      zoom: 14.4746,
    );

    await Future.delayed(const Duration(seconds: 1));
    final GoogleMapController controller = await _controller.future;
    setState((){
      controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
    });
  }

  @override
  initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          markers: <Marker>{_setMarker()},
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed:_nearest_oldage_home,
          label: Text('nearest oldage home'),
          icon: Icon(Icons.directions_boat),
        ),
      ),
    );
  }


  _setMarker() {
    return Marker(
      markerId: MarkerId("marker_1"),
      icon: BitmapDescriptor.defaultMarker,
      position: _latLng!,
    );
  }

  Future<void> _nearest_oldage_home() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_eldersheaven));
  }
}*/

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  static const routname = "/mapscreen";
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng? _currentPosition;
  List<Place> _places = [];

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(28.6289206, 77.2065322),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });
    _getNearbyPlaces();
  }

  Future<void> _getNearbyPlaces() async {
    final url =
       'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${_currentPosition!.latitude},${_currentPosition!.longitude}&radius=10000&keyword=old age homes&key=YOUR_API_KEY';
    final response = await http.get(Uri.parse(url));
    final json = jsonDecode(response.body);
    final results = json['results'] as List<dynamic>;
    setState(() {
      _places = results.map((result) => Place.fromMap(result)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        markers: _buildMarkers(),
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  Set<Marker> _buildMarkers() {
    final markers = <Marker>{};
    if (_currentPosition != null) {
      markers.add(Marker(
        markerId: MarkerId('current'),
        position: _currentPosition!,
      ));
    }
    for (final place in _places) {
      markers.add(Marker(
        markerId: MarkerId(place.id),
        position: place.position,
        infoWindow: InfoWindow(title: place.name),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      ));
    }
    return markers;
  }
}

class Place {
  final String id;
  final String name;
  final LatLng position;

  Place({
    required this.id,
    required this.name,
    required this.position,
  });

  factory Place.fromMap(Map<String, dynamic> map) {
    final id = map['place_id'] as String;
    final name = map['name'] as String;
    final lat = map['geometry']['location']['lat'] as double;
    final lng = map['geometry']['location']['lng'] as double;
    final position = LatLng(lat, lng);
    return Place(id: id, name: name, position: position);
  }
}


/*import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice_ex/places.dart' as Places;
import 'package:location/location.dart';
import 'package:google_maps_webservice_ex/src/core/utils/spherical.dart';

class MapScreen extends StatefulWidget {
  static const routname = "/mapscreen";

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng? _latLng = LatLng(28.6472799, 76.8130638);

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(28.6289206, 77.2065322),
    zoom: 14.4746,
  );

  static final CameraPosition _eldersheaven = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(13.3346314, 77.1325076),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  Future<void> getCurrentLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    _latLng = LatLng(_locationData.latitude!, _locationData.longitude!);
    print(_latLng);

    _kGooglePlex = CameraPosition(
      target: _latLng!,
      zoom: 14.4746,
    );

    await Future.delayed(const Duration(seconds: 1));
    final GoogleMapController controller = await _controller.future;
    setState(() {
      controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
    });

    _getNearestOldAgeHome(_latLng!);
  }

  @override
  initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          markers: <Marker>{_setMarker()},
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _getNearestOldAgeHome(_latLng!);
          },
          label: Text('nearest oldage home'),
          icon: Icon(Icons.directions_boat),
        ),
      ),
    );
  }

  _setMarker() {
    return Marker(
      markerId: MarkerId("marker_1"),
      icon: BitmapDescriptor.defaultMarker,
      position: _latLng!,
    );
  }

  Future<void> _getNearestOldAgeHome(LatLng latLng) async {
    final places = Places.GoogleMapsPlaces(apiKey: "YOUR_API_KEY");

    // Define the type of place we want to search for (old age home in this case)
    const String PLACE_TYPE = "health";
    const String PLACE_KEYWORD = "old age home";

    // Define the search request parameters
    final request = Places.PlacesSearchRequest(
      location: latLng,
      radius: 10000, // in meters
      type: PLACE_TYPE,
      keyword: PLACE_KEYWORD,
    );

    // Send the search request to Google Places API
    final response = await places.searchNearby(request);

    // Check if any places were found
    if (response.status == Places.PlacesSearchStatusCodes.OK) {
      // Sort the places by distance from the provided coordinates
      response.results.sort((a, b) {
        final distanceToA = SphericalUtil.computeDistanceBetween(
          latLng,
          LatLng(a.geometry.location.lat, a.geometry.location.lng),
        );
        final distanceToB = SphericalUtil.computeDistanceBetween(
          latLng,
          LatLng(b.geometry.location.lat, b.geometry.location.lng),
        );
        return distanceToA.compareTo(distanceToB);
      });

      // Get the nearest old age home
      final nearestPlace = response.results.first;

      // Move the camera to the nearest place
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            nearestPlace.geometry.location.lat,
            nearestPlace.geometry.location.lng,
          ),
          zoom: 14.0,
        ),
      ));
    } else {
      // No places found
      print("No old age homes found nearby.");
    }
  }
}*/

