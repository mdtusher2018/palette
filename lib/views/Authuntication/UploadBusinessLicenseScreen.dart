import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette/controller/auth_controller.dart';
import 'package:palette/views/res/commonWidgets.dart';

class UploadBusinessLicenseScreen extends StatefulWidget {
  final String establishType;
  final String establishName;
  final String email;
  final String password;
  final double latitude;
  final double longitude;

  const UploadBusinessLicenseScreen({
    Key? key,
    required this.establishType,
    required this.establishName,
    required this.email,
    required this.password,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  State<UploadBusinessLicenseScreen> createState() =>
      _UploadBusinessLicenseScreenState();
}

class _UploadBusinessLicenseScreenState
    extends State<UploadBusinessLicenseScreen> {
  File? pickedFile;

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png'],
    );

    if (result != null && result.files.isNotEmpty) {
      final path = result.files.first.path;
      if (path != null) {
        setState(() {
          pickedFile = File(path); // ✅ Fix: Convert to File
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Image.asset('assets/images/logo.png', height: 100),
            commonText("Palette", size: 20, isBold: true),
            const SizedBox(height: 20),
            commonText("Upload Your Business Licence", size: 18, isBold: true),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Icon(Icons.cloud_upload_outlined,
                      size: 40, color: Colors.pink),
                  const SizedBox(height: 12),
                  commonText("Upload files", size: 16, isBold: true),
                  commonText("Max file size: 25 MB", size: 12),
                  const SizedBox(height: 12),
                  commonButton("Browse Files", onTap: () {
                    pickFile();
                  }, borderRadious: 10, width: 120, height: 30, textSize: 14),
                  if (pickedFile != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      pickedFile!.path,
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ]
                ],
              ),
            ),
            const Spacer(),
            commonButton("Continue",
                onTap: pickedFile == null
                    ? null
                    : () {
                        Get.put(AuthController()).signUpEstablishOwner(
                            estublishName: widget.establishName,
                            email: widget.email,
                            password: widget.password,
                            image: pickedFile!,
                            long: widget.longitude,
                            lat: widget.latitude);
                      }),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
