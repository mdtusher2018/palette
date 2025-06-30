import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:palette/controller/explore_controller.dart';
import 'package:palette/models/explore/near_by_resturant.dart';
import 'package:palette/views/res/colors.dart';
import 'package:palette/views/res/commonWidgets.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  ExploreController controller = Get.find<ExploreController>();
  GoogleMapController? _mapController;

  LatLng _initialPosition = const LatLng(23.7634868, 90.4323847); // BD center
  Set<Marker> _markers = {};
  Marker? _pickedLocationMarker;
  Circle? _pickedLocationCircle;
  double zoom = 13.0;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;

    final position = await Geolocator.getCurrentPosition();
    _initialPosition = LatLng(position.latitude, position.longitude);

    await controller.fetchNearbyRestaurants(
      lat: position.latitude,
      lng: position.longitude,
    );

    _buildMarkers();
  }

  void _buildMarkers() {
    final markerList = controller.mapresturents.map((restaurant) {
      return Marker(
        markerId: MarkerId(restaurant.id),
        position: LatLng(
          restaurant.location.latitude,
          restaurant.location.longitude,
        ),
        infoWindow: InfoWindow(title: restaurant.fullName),
        onTap: () {
          _showBottomSheet(restaurant);
        },
      );
    }).toSet();

    // Add picked marker if exists
    if (_pickedLocationMarker != null) {
      markerList.add(_pickedLocationMarker!);
    }

    setState(() {
      _markers = markerList;
    });
  }

  void _showBottomSheet(RestaurantAttribute restaurant) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(restaurant.fullName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(
                'Lat: ${restaurant.location.latitude}, Lng: ${restaurant.location.longitude}',
                style: TextStyle(color: Colors.grey[700]),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // You can also navigate to detail page here if needed
                },
                child: Text("Close"),
              )
            ],
          ),
        );
      },
    );
  }

  void _handleMapTap(LatLng position) async {
    print("🗺️ Map tapped at: ${position.latitude}, ${position.longitude}");

    await controller.fetchNearbyRestaurants(
      lat: position.latitude,
      lng: position.longitude,
    );

    _mapController?.animateCamera(CameraUpdate.newLatLng(position));

    _pickedLocationMarker = Marker(
      markerId: MarkerId("picked_location"),
      position: position,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      infoWindow: InfoWindow(title: "Selected Location"),
    );

    _pickedLocationCircle = Circle(
      circleId: CircleId("picked_location_circle"),
      center: position,
      radius: 5000, // in meters => 5km
      fillColor: Colors.blue.withOpacity(0.2),
      strokeColor: Colors.blue,
      strokeWidth: 2,
    );

    _buildMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: _initialPosition, zoom: zoom),
            onMapCreated: (controller) => _mapController = controller,
            markers: _markers,
            circles:
                _pickedLocationCircle != null ? {_pickedLocationCircle!} : {},
            onTap: _handleMapTap,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          if (controller.isLoading.value)
            const Center(child: CircularProgressIndicator()),
          if (controller.errorMessage.value != null &&
              controller.errorMessage.value!.isNotEmpty)
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Material(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: commonText(controller.errorMessage.value!,
                        color: AppColors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
