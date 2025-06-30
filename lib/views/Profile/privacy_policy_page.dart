import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:palette/controller/StaticContentController.dart';
import 'package:palette/repositories/StaticContentRepository.dart';
import 'package:palette/services/StaticContentService.dart';
import 'package:palette/services/api_service.dart';
import 'package:palette/views/res/colors.dart';
import 'package:palette/views/res/commonWidgets.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  late StaticContentController staticContentController;

  @override
  void initState() {
    super.initState();

    final apiService = ApiService();
    final staticContentService = StaticContentService(apiService);
    final staticContentRepository =
        StaticContentRepository(staticContentService);
    staticContentController =
        Get.put(StaticContentController(staticContentRepository));

    // Fetch privacy policy markdown content from API
    staticContentController.fetchStaticContent('privacy-policy');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: commonBackButton(),
        centerTitle: true,
        title: commonText(
          "Privacy Policy",
          size: 21,
          isBold: true,
          color: AppColors.white,
        ),
      ),
      body: Obx(() {
        if (staticContentController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (staticContentController.errorMessage.isNotEmpty) {
          return Center(
            child: commonText(
              "Error: ${staticContentController.errorMessage.value}",
              color: Colors.red,
            ),
          );
        }

        final content = staticContentController
                .staticContentResponse.value?.attributes.content ??
            'No content available';

        return Container(
          padding: const EdgeInsets.all(8),
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Html(
            data: content,
          ),
        );
      }),
    );
  }
}
