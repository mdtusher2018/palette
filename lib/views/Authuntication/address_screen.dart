// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:palette/views/Authuntication/UploadBusinessLicenseScreen.dart';
import 'package:palette/views/res/commonWidgets.dart';

class AddBusinessAddressScreen extends StatefulWidget {
  String estublishType, estublishName, email, password;

  AddBusinessAddressScreen(
      {super.key,
      required this.estublishName,
      required this.email,
      required this.password,
      required this.estublishType});

  @override
  _AddBusinessAddressScreenState createState() =>
      _AddBusinessAddressScreenState();
}

class _AddBusinessAddressScreenState extends State<AddBusinessAddressScreen> {
  late GoogleMapController mapController;
  LatLng? selectedPosition;
  TextEditingController addressController = TextEditingController();

  void _onMapTap(LatLng position) async {
    setState(() {
      selectedPosition = position;
    });

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      addressController.text =
          "${place.street}, ${place.locality}, ${place.country}";
    }
  }

  Future<void> _searchAddress() async {
    final query = addressController.text.trim();
    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: commonText("Please enter an address")),
      );
      return;
    }

    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final location = locations.first;
        final newPos = LatLng(location.latitude, location.longitude);

        setState(() {
          selectedPosition = newPos;
        });

        mapController.animateCamera(CameraUpdate.newLatLng(newPos));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: commonText("No results found")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: commonText("Address not found,Please pick Manually",
                color: Colors.white)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 120,
            ), // Use your logo
            commonText("Palette", size: 20, isBold: true),
            commonText("Add Your Business Address", size: 18, isBold: true),
            const SizedBox(height: 12),

            commonTextfieldWithTitle(
              "Business Address",
              addressController,
              onFieldSubmit: (p0) {
                _searchAddress();
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: GoogleMap(
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(23.7806, 90.40744), // Default to Dhaka
                    zoom: 14,
                  ),
                  onMapCreated: (controller) => mapController = controller,
                  onTap: _onMapTap,
                  markers: selectedPosition != null
                      ? {
                          Marker(
                            markerId: const MarkerId("selected"),
                            position: selectedPosition!,
                          )
                        }
                      : {},
                ),
              ),
            ),
            const SizedBox(height: 20),
            commonButton("Continue", onTap: () {
              if (selectedPosition == null) {
                Get.snackbar(
                  "Required Location",
                  "Please select you location before continuing.",
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
              navigateToPage(
                UploadBusinessLicenseScreen(
                  establishType: widget.estublishType,
                  establishName: widget.estublishName,
                  email: widget.email,
                  password: widget.password,
                  latitude: selectedPosition!.latitude,
                  longitude: selectedPosition!.longitude,
                ),
              );
            }),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
