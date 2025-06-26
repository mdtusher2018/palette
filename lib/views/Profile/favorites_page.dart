// import 'package:flutter/material.dart';
// import 'package:palette/views/Profile/favourite_items_page.dart';
// import 'package:palette/views/res/colors.dart';
// import 'package:palette/views/res/commonWidgets.dart';

// class FavoritesPage extends StatelessWidget {
//   FavoritesPage({super.key});

//   final Map<String, List<String>> favorites = {
//     "Ramen's": [
//       'https://tse1.mm.bing.net/th/id/OIP.iZmRJpSySKsI7x8gUlTSyAHaEz?rs=1&pid=ImgDetMain',
//       'https://tse3.mm.bing.net/th/id/OIP.1Vw2Q5yg2-QQyolad3TyawHaE2?w=5184&h=3397&rs=1&pid=ImgDetMain',
//       'https://tse3.mm.bing.net/th/id/OIP.sZ4EFVSzgw4TxTESZR5PBQHaLH?w=800&h=1200&rs=1&pid=ImgDetMain',
//       'https://tse4.mm.bing.net/th/id/OIP.paZokRr6HFdXZQoIAKmDjgHaEK?rs=1&pid=ImgDetMain',
//     ],
//     "Burger’s": [
//       'https://tse1.mm.bing.net/th/id/OIP.iZmRJpSySKsI7x8gUlTSyAHaEz?rs=1&pid=ImgDetMain',
//       'https://tse3.mm.bing.net/th/id/OIP.1Vw2Q5yg2-QQyolad3TyawHaE2?w=5184&h=3397&rs=1&pid=ImgDetMain',
//       'https://tse3.mm.bing.net/th/id/OIP.sZ4EFVSzgw4TxTESZR5PBQHaLH?w=800&h=1200&rs=1&pid=ImgDetMain',
//       'https://tse4.mm.bing.net/th/id/OIP.paZokRr6HFdXZQoIAKmDjgHaEK?rs=1&pid=ImgDetMain',
//     ],
//     "My Fav Restaurants": [
//       'https://tse1.mm.bing.net/th/id/OIP.iZmRJpSySKsI7x8gUlTSyAHaEz?rs=1&pid=ImgDetMain',
//       'https://tse3.mm.bing.net/th/id/OIP.1Vw2Q5yg2-QQyolad3TyawHaE2?w=5184&h=3397&rs=1&pid=ImgDetMain',
//       'https://tse3.mm.bing.net/th/id/OIP.sZ4EFVSzgw4TxTESZR5PBQHaLH?w=800&h=1200&rs=1&pid=ImgDetMain',
//       'https://tse4.mm.bing.net/th/id/OIP.paZokRr6HFdXZQoIAKmDjgHaEK?rs=1&pid=ImgDetMain',
//     ],
//     "3Ramen's": [
//       'https://tse1.mm.bing.net/th/id/OIP.iZmRJpSySKsI7x8gUlTSyAHaEz?rs=1&pid=ImgDetMain',
//       'https://tse3.mm.bing.net/th/id/OIP.1Vw2Q5yg2-QQyolad3TyawHaE2?w=5184&h=3397&rs=1&pid=ImgDetMain',
//       'https://tse3.mm.bing.net/th/id/OIP.sZ4EFVSzgw4TxTESZR5PBQHaLH?w=800&h=1200&rs=1&pid=ImgDetMain',
//       'https://tse4.mm.bing.net/th/id/OIP.paZokRr6HFdXZQoIAKmDjgHaEK?rs=1&pid=ImgDetMain',
//     ],
//     "3Burger’s": [
//       'https://tse1.mm.bing.net/th/id/OIP.iZmRJpSySKsI7x8gUlTSyAHaEz?rs=1&pid=ImgDetMain',
//       'https://tse3.mm.bing.net/th/id/OIP.1Vw2Q5yg2-QQyolad3TyawHaE2?w=5184&h=3397&rs=1&pid=ImgDetMain',
//       'https://tse3.mm.bing.net/th/id/OIP.sZ4EFVSzgw4TxTESZR5PBQHaLH?w=800&h=1200&rs=1&pid=ImgDetMain',
//       'https://tse4.mm.bing.net/th/id/OIP.paZokRr6HFdXZQoIAKmDjgHaEK?rs=1&pid=ImgDetMain',
//     ],
//     "3My Fav Restaurants": [
//       'https://tse1.mm.bing.net/th/id/OIP.iZmRJpSySKsI7x8gUlTSyAHaEz?rs=1&pid=ImgDetMain',
//       'https://tse3.mm.bing.net/th/id/OIP.1Vw2Q5yg2-QQyolad3TyawHaE2?w=5184&h=3397&rs=1&pid=ImgDetMain',
//       'https://tse3.mm.bing.net/th/id/OIP.sZ4EFVSzgw4TxTESZR5PBQHaLH?w=800&h=1200&rs=1&pid=ImgDetMain',
//       'https://tse4.mm.bing.net/th/id/OIP.paZokRr6HFdXZQoIAKmDjgHaEK?rs=1&pid=ImgDetMain',
//     ],
//     "2Ramen's": [
//       'https://tse1.mm.bing.net/th/id/OIP.iZmRJpSySKsI7x8gUlTSyAHaEz?rs=1&pid=ImgDetMain',
//       'https://tse3.mm.bing.net/th/id/OIP.1Vw2Q5yg2-QQyolad3TyawHaE2?w=5184&h=3397&rs=1&pid=ImgDetMain',
//       'https://tse3.mm.bing.net/th/id/OIP.sZ4EFVSzgw4TxTESZR5PBQHaLH?w=800&h=1200&rs=1&pid=ImgDetMain',
//       'https://tse4.mm.bing.net/th/id/OIP.paZokRr6HFdXZQoIAKmDjgHaEK?rs=1&pid=ImgDetMain',
//     ],
//     "2Burger’s": [
//       'https://tse1.mm.bing.net/th/id/OIP.iZmRJpSySKsI7x8gUlTSyAHaEz?rs=1&pid=ImgDetMain',
//       'https://tse3.mm.bing.net/th/id/OIP.1Vw2Q5yg2-QQyolad3TyawHaE2?w=5184&h=3397&rs=1&pid=ImgDetMain',
//       'https://tse3.mm.bing.net/th/id/OIP.sZ4EFVSzgw4TxTESZR5PBQHaLH?w=800&h=1200&rs=1&pid=ImgDetMain',
//       'https://tse4.mm.bing.net/th/id/OIP.paZokRr6HFdXZQoIAKmDjgHaEK?rs=1&pid=ImgDetMain',
//     ],
//     "2My Fav Restaurants": [
//       'https://tse1.mm.bing.net/th/id/OIP.iZmRJpSySKsI7x8gUlTSyAHaEz?rs=1&pid=ImgDetMain',
//       'https://tse3.mm.bing.net/th/id/OIP.1Vw2Q5yg2-QQyolad3TyawHaE2?w=5184&h=3397&rs=1&pid=ImgDetMain',
//       'https://tse3.mm.bing.net/th/id/OIP.sZ4EFVSzgw4TxTESZR5PBQHaLH?w=800&h=1200&rs=1&pid=ImgDetMain',
//       'https://tse4.mm.bing.net/th/id/OIP.paZokRr6HFdXZQoIAKmDjgHaEK?rs=1&pid=ImgDetMain',
//     ],
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primary,
//       appBar: AppBar(
//         title: commonText("Favorites",
//             size: 21, isBold: true, color: AppColors.white),
//         leading: commonBackButton(),
//         backgroundColor: AppColors.primary,
//         elevation: 0,
//       ),
//       bottomSheet: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: GridView.count(
//           crossAxisCount: 2,
//           mainAxisSpacing: 20,
//           childAspectRatio: 0.9,
//           crossAxisSpacing: 10,
//           shrinkWrap: true,
//           children: favorites.entries.map((entry) {
//             final images = entry.value.take(4).toList();
//             return InkWell(
//               onTap: () {
//                 navigateToPage(TopicWiseFavoritePage());
//               },
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: GridView.count(
//                         mainAxisSpacing: 4,
//                         crossAxisSpacing: 4,
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         crossAxisCount: 2,
//                         children: images.map((url) {
//                           return Image.network(
//                             url,
//                             fit: BoxFit.cover,
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                   ),
//                   commonText(entry.key,
//                       isBold: true, size: 16, color: AppColors.black),
//                 ],
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }
