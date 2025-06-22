import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette/models/user%20models/UserCurrentChallengeModel.dart';
import 'package:palette/utils/helper.dart';
import 'package:palette/views/res/image_path.dart';
import 'package:palette/views/res/colors.dart';
import 'package:palette/views/res/commonWidgets.dart';
import 'package:palette/views/res/video_screen.dart';

Widget badgesCard({required String imageUrl, required String name}) {
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: AppColors.primary)),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        if (name.isNotEmpty)
          FittedBox(
              fit: BoxFit.scaleDown,
              child: commonText(name, size: 14, isBold: true, maxline: 1))
      ],
    ),
  );
}

Widget challengeCard(SingleChallenge data) {
  double progress = data.completionRatio;

  return Container(
    decoration: BoxDecoration(
      color: AppColors.textFieldColor,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.primary),
    ),
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            commonText(data.challengeTitle,
                size: 16, isBold: true, color: AppColors.black),
            commonText("${data.progress}/${data.requiredSteps}",
                size: 14, isBold: true, color: AppColors.primary),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white,
            color: AppColors.primary,
            minHeight: 12,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: commonText(data.challengeDescription,
                  size: 12, color: AppColors.gray),
            ),
            SizedBox(
              width: 16,
            ),
            Row(
              children: List.generate(data.requiredSteps, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1.5),
                  child: Icon(
                    Icons.circle,
                    size: 8,
                    color: index < data.progress
                        ? AppColors.primary
                        : AppColors.gray.withOpacity(0.2),
                  ),
                );
              }),
            )
          ],
        ),
      ],
    ),
  );
}

Widget buildLogsCardDesign({
  required String iteamName,
  required String image,
  required String restaurent,
  required String ratting,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.all(8),
          child: Container(
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(getFullImagePath(image)),
                    fit: BoxFit.cover,
                  ))),
        ),
        ListTile(
          title: commonText(iteamName, size: 16, isBold: true),
          subtitle: Row(
            children: [
              Image.asset(AppAssetsPath.locationIcon),
              commonText(restaurent, size: 12, isBold: true),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, color: Colors.orange, size: 14),
              commonText(ratting, size: 12),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildPostCardDesign(
    {required String profileImage,
    required String profileName,
    required String menuImagePath,
    required String name,
    required String time,
    required String resturant,
    required String ratting}) {
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    padding: EdgeInsets.symmetric(horizontal: 2),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 1,
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 8),
            leading: CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(getFullImagePath(profileImage)),
            ),
            title: commonText(profileName, size: 16, isBold: true),
            subtitle: commonText(
              time,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
                height: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage((menuImagePath.isNotEmpty)
                      ? getFullImagePath(menuImagePath)
                      : "https://th.bing.com/th/id/OIP.jUfCu2A6ilKJAdybISEMgwHaHa?rs=1&pid=ImgDetMain&cb=idpwebpc2"),
                  fit: BoxFit.cover,
                ))),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 8),
            title: commonText(name, size: 16, isBold: true),
            subtitle: Row(
              children: [
                Image.asset(AppAssetsPath.locationIcon),
                commonText(resturant, size: 12, isBold: true),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star, color: Colors.orange, size: 14),
                commonText(ratting, size: 12),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget cardDesign(
    {required String name,
    required imageUrl,
    required String buttonName,
    required String ratting,
    bool isleft = true,
    width,
    bool isdelete = false,
    required String location}) {
  Widget badge(String label) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(4),
      ),
      child: commonText(label, size: 14, isBold: true, color: AppColors.white),
    );
  }

  return Container(
    width: width,
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: NetworkImage(imageUrl), fit: BoxFit.cover)),
              ),
              Positioned(
                top: 8,
                left: (isleft) ? 8 : null,
                right: (isleft) ? null : 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.star, size: 16, color: Colors.orange),
                      SizedBox(width: 2),
                      commonText(ratting, isBold: true),
                    ],
                  ),
                ),
              ),
              if (isdelete)
                Positioned(
                  top: 8,
                  left: (isleft) ? null : 8,
                  right: (isleft) ? 8 : null,
                  child: Image.asset(
                    AppAssetsPath.delete,
                    width: 24,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 8),
        commonText(name, size: 16, isBold: true),
        SizedBox(height: 4),
        badge(buttonName),
        SizedBox(height: 4),
        Row(
          children: [
            Image.asset(AppAssetsPath.locationIcon),
            SizedBox(width: 4),
            Expanded(
              child: commonText(location, size: 12, isBold: true),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildReviews(
    {required List<Map<String, dynamic>> reviews,
    bool shrinkWrap = false,
    physics}) {
  return ListView.builder(
    itemCount: reviews.length,
    padding: EdgeInsets.all(0),
    shrinkWrap: shrinkWrap,
    physics: physics,
    itemBuilder: (context, index) {
      final review = reviews[index];
      return Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                      NetworkImage(review["profileImage"].toString()),
                ),
                SizedBox(width: 8),
                commonText(review["name"].toString(), size: 16, isBold: true),
                Spacer(),
                Icon(Icons.star, color: Colors.orange, size: 16),
                commonText(review["rating"].toString(), size: 14, isBold: true),
              ],
            ),
            SizedBox(height: 8),
            commonText(review["text"].toString(),
                size: 13, maxline: 5, softwarp: true),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  if ((review["commentImage"] ?? "").toString().isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => Dialog(
                            child: InteractiveViewer(
                              child: Image.network(review["commentImage"]),
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          review["commentImage"],
                          height: 100,
                          width: 160,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  if ((review["video"] ?? "").toString().isNotEmpty &&
                      (review["commentImage"] ?? "").toString().isNotEmpty)
                    SizedBox(width: 16),
                  if ((review["video"] ?? "").toString().isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) => Dialog(
                                  backgroundColor: Colors.transparent,
                                  insetPadding: EdgeInsets.zero,
                                  child: InteractiveViewer(
                                    child: VideoApp(
                                        videoUrl:
                                            "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"),
                                  ),
                                ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            height: 100,
                            width: 160,
                            child: VideoApp(
                                videoUrl:
                                    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"
                                // review["video"]
                                ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 4),
            commonText(getTimeDifference(review["time"].toString()),
                size: 14, isBold: true),
          ],
        ),
      );
    },
  );
}

Widget menuCard(
    {Function()? onTap,
    required String imageUrl,
    required String name,
    required String description,
    required String price,
    required String rating,
    required String catagory}) {
  return InkWell(
    onTap: onTap,
    child: Card(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
                width: 100,
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(imageUrl)))),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: commonText(name, size: 16.0, isBold: true)),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          commonText(rating,
                              size: 14.0, color: AppColors.black),
                        ],
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: commonText(catagory,
                        color: AppColors.white, isBold: true),
                  ),
                  commonText(
                    description,
                    color: AppColors.black,
                  ),
                  SizedBox(height: 4),
                  commonText("\$$price",
                      size: 14, color: AppColors.primary, isBold: true),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void showAddToFavoriteDialog(BuildContext context,
    {required List<Map<String, String>> favorites,
    required Function(String) postFolder,
    required Function(String id) onFolderTap}) {
  final TextEditingController _controller = TextEditingController();
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Color(0xFFFDFBFA),
        child: StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    commonText('Add to Favorite',
                        size: 18, isBold: true, color: AppColors.black),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: 'Type',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 16),
                              filled: true,
                              fillColor: Color(0xFFFFEAE6),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        GestureDetector(
                          onTap: () async {
                            if (_controller.text.trim().isNotEmpty) {
                              final folderName = _controller.text.trim();
                              final id = await postFolder(folderName);
                              if (id != null && id.isNotEmpty) {
                                setState(() {
                                  favorites.add({
                                    'foldername': folderName,
                                    'id': id,
                                  });
                                  _controller.clear();
                                });
                              }
                            }
                          },
                          child: Container(
                            height: 44,
                            width: 44,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFA9A2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ...favorites.reversed.map(
                            (item) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: InkWell(
                                onTap: () {
                                  onFolderTap(item['id']!);
                                  Get.back();
                                },
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                        color: Color(0xFFFFA9A2), width: 2),
                                  ),
                                  child: commonText(
                                    item['foldername']!,
                                    color: Color(0xFFBA5D4D),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                  ],
                );
              },
            ),
          );
        }),
      );
    },
  );
}
