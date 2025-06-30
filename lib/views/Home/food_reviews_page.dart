// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:palette/views/res/colors.dart';
import 'package:palette/views/res/commonDesigns.dart';
import 'package:palette/views/res/commonWidgets.dart';

class FoodReviewsPage extends StatelessWidget {
  List<Map<String, dynamic>> reviews;
  FoodReviewsPage({
    super.key,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: commonText("Reviews",
            size: 21, isBold: true, color: AppColors.white),
        leading: commonBackButton(),
      ),
      backgroundColor: AppColors.primary,
      bottomSheet: Padding(
        padding: EdgeInsets.all(16),
        child: buildReviews(reviews: reviews, maxline: 100000),
      ),
    );
  }
}
