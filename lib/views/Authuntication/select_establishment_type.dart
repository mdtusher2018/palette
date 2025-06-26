// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette/views/Authuntication/address_screen.dart';
import 'package:palette/views/res/colors.dart';
import '../res/commonWidgets.dart';
import '../res/image_path.dart';

class SelectEstablishmentType extends StatefulWidget {
  SelectEstablishmentType(
      {super.key,
      required this.estublishName,
      required this.email,
      required this.password});

  String estublishName, email, password;
  @override
  State<SelectEstablishmentType> createState() =>
      _SelectEstablishmentTypeState();
}

class _SelectEstablishmentTypeState extends State<SelectEstablishmentType> {
  final List<String> _categories = [
    'Restaurant',
    'Cafés',
    'Bars',
    'Bakeries',
    'Juice Shops',
  ];

  String? selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Image.asset(AppAssetsPath.logo, height: 150),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: commonText(
                      "Select Your Establishment Type",
                      isBold: true,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                commonText("Select Type", size: 14, isBold: true),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            DropdownButtonFormField<String>(
              value: selected,
              items: _categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: commonText(category, size: 16),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selected = value;
                });
              },
              hint: commonText("Select Establishment Type", size: 16),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: AppColors.primary.withOpacity(0.15),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              icon: const Icon(Icons.arrow_drop_down),
              dropdownColor: Colors.white,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            Spacer(),
            commonButton(
              "Continue",
              onTap: () {
                if (selected == null || selected!.isEmpty) {
                  Get.snackbar(
                    "Required Field",
                    "Please select an establishment type before continuing.",
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                } else {
                  navigateToPage(AddBusinessAddressScreen(
                    email: widget.email,
                    estublishName: widget.estublishName,
                    estublishType: selected!,
                    password: widget.password,
                  ));
                }
              },
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
