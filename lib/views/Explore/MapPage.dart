// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:palette/views/res/commonWidgets.dart';

// class MapPage extends StatefulWidget {
//   const MapPage({Key? key}) : super(key: key);

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   GoogleMapController? _mapController;
//   final Location _location = Location();
//   LatLng _initialPosition = const LatLng(37.7749, -122.4194); // Default to SF

//   @override
//   void initState() {
//     super.initState();
//     _getUserLocation();
//   }

//   Future<void> _getUserLocation() async {
//     bool serviceEnabled = await _location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await _location.requestService();
//     }

//     PermissionStatus permissionGranted = await _location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await _location.requestPermission();
//     }

//     if (permissionGranted == PermissionStatus.granted ||
//         permissionGranted == PermissionStatus.grantedLimited) {
//       final userLocation = await _location.getLocation();
//       setState(() {
//         _initialPosition =
//             LatLng(userLocation.latitude!, userLocation.longitude!);
//       });

//       _mapController?.animateCamera(CameraUpdate.newLatLng(_initialPosition));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: commonText('Google Map Integration'),
//       ),
//       body: GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: _initialPosition,
//         ),
//         onMapCreated: (controller) {
//           _mapController = controller;
//         },
//         myLocationEnabled: true,
//         myLocationButtonEnabled: true,
//         zoomControlsEnabled: false,
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? mapController;
  LatLng _initialPosition =
      const LatLng(37.7749, -122.4194); // Default to San Francisco
  Set<Marker> _markers = {};
  String apiKey =
      'AIzaSyATSv5h_egKxfkIHDob5a48AH2E85QrEpU'; // Replace with your key

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;

    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    _initialPosition = LatLng(position.latitude, position.longitude);
    mapController?.animateCamera(CameraUpdate.newLatLng(_initialPosition));

    _fetchNearbyRestaurants(position.latitude, position.longitude);
  }

  Future<void> _fetchNearbyRestaurants(double lat, double lng) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=1500&type=restaurant&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);

    if (data['status'] == 'OK') {
      final places = data['results'] as List;
      final Set<Marker> loadedMarkers = {};

      for (var place in places) {
        final location = place['geometry']['location'];
        final marker = Marker(
          markerId: MarkerId(place['place_id']),
          position: LatLng(location['lat'], location['lng']),
          infoWindow: InfoWindow(
            title: place['name'],
            snippet: place['vicinity'],
          ),
        );
        loadedMarkers.add(marker);
      }

      setState(() {
        _markers = loadedMarkers;
      });
    } else {
      debugPrint("Places API error: ${data['status']}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: _initialPosition, zoom: 14),
        onMapCreated: (controller) {
          mapController = controller;
        },
        markers: _markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
