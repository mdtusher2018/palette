import 'package:flutter/material.dart';
import 'package:palette/views/res/colors.dart';
import 'package:get/get.dart';

Widget commonText(
  String text, {
  double size = 12.0,
  Color color = Colors.black,
  bool isBold = false,
  softwarp,
  maxline = 1000,
  bool haveUnderline = false,
  fontWeight,
  TextAlign textAlign = TextAlign.left,
}) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    maxLines: maxline,
    softWrap: softwarp,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: size,
      decoration:
          (haveUnderline) ? TextDecoration.underline : TextDecoration.none,
      color: color,
      fontWeight: isBold
          ? FontWeight.bold
          : (fontWeight != null)
              ? fontWeight
              : FontWeight.normal,
    ),
  );
}

Widget commonTextfieldWithTitle(
  String title,
  TextEditingController controller, {
  FocusNode? focusNode,
  String hintText = "",
  bool isBold = true,
  bool issuffixIconVisible = false,
  bool isPasswordVisible = false,
  enable,
  textSize = 14.0,
  suffixIcon,
  borderWidth = 0.0,
  optional = false,
  changePasswordVisibility,
  TextInputType keyboardType = TextInputType.text,
  String? assetIconPath,
  Color borderColor = Colors.grey,
  Color color = AppColors.textFieldColor,
  int maxLine = 1,
  String? Function(String?)? onValidate,
  Function(String?)? onFieldSubmit,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          commonText(title, size: textSize, isBold: isBold),
          if (optional)
            commonText("(Optional)", size: textSize, color: Colors.grey),
        ],
      ),
      const SizedBox(height: 8),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: borderColor, width: borderWidth),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: TextFormField(
            controller: controller,
            enabled: enable,
            focusNode: focusNode,
            validator: onValidate,
            obscuringCharacter: "*",
            onFieldSubmitted: onFieldSubmit,
            keyboardType: keyboardType,
            maxLines: maxLine,
            obscureText: isPasswordVisible,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(12.0),
              hintText: hintText,
              fillColor: color,
              filled: true,
              hintStyle: TextStyle(fontSize: 14, color: AppColors.black),
              border: InputBorder.none,
              suffixIcon: (issuffixIconVisible)
                  ? (!isPasswordVisible)
                      ? InkWell(
                          onTap: changePasswordVisibility,
                          child: Icon(Icons.visibility),
                        )
                      : InkWell(
                          onTap: changePasswordVisibility,
                          child: Icon(Icons.visibility_off_outlined),
                        )
                  : suffixIcon,
              prefixIcon: assetIconPath != null
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ImageIcon(
                        AssetImage(assetIconPath),
                        size: 24.0,
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget commonBackButton() {
  return InkWell(
    onTap: () {
      Get.back();
    },
    child: Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
          border: Border.all(width: 1),
          shape: BoxShape.circle,
          color: AppColors.white),
      child: Icon(Icons.arrow_back),
    ),
  );
}

void navigateToPage(Widget page,
    {bool replace = false,
    bool clearStack = false,
    Transition transition = Transition.rightToLeft,
    Duration duration = const Duration(milliseconds: 400),
    onPop}) {
  if (clearStack) {
    Get.offAll(page, transition: transition, duration: duration)!
        .then(onPop ?? (value) {});
  } else if (replace) {
    Get.off(page, transition: transition, duration: duration)!
        .then(onPop ?? (value) {});
  } else {
    Get.to(page, transition: transition, duration: duration)!
        .then(onPop ?? (value) {});
  }
}

void commonSnackbar(BuildContext context, String message,
    {Color? backgroundColor, Duration duration = const Duration(seconds: 3)}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: commonText(message),
      backgroundColor: backgroundColor ?? Colors.redAccent,
      duration: duration,
    ),
  );
}

Widget commonButton(
  String title, {
  Color color = AppColors.primary,
  Color textColor = AppColors.white,
  double textSize = 18,
  double width = double.infinity,
  double height = 50,
  VoidCallback? onTap,
  TextAlign textalign = TextAlign.left,
  bool isLoading = false,
  double borderRadious = 50.0,
  bool haveNextIcon = false,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadious)),
        color: color,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: isLoading
              ? const CircularProgressIndicator()
              : FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      commonText(
                        textAlign: textalign,
                        title,
                        size: textSize,
                        color: textColor,
                        isBold: true,
                      ),
                      if (haveNextIcon)
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Image.asset("assets/arrow.png"),
                        ),
                    ],
                  ),
                ),
        ),
      ),
    ),
  );
}

Widget commonSmallButton({
  required String text,
  double radious = 16.0,
  ontap,
  double borderWidth = 2.0,
  double width = 80.0,
  bool haveIcon = false,
  double verticalPadding = 4,
  Widget? icon,
  double fontSize = 12.0,
  color = AppColors.white,
  textColor = AppColors.primary,
}) {
  return InkWell(
    onTap: ontap,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      width: width,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radious),
          border: Border.all(
              width: borderWidth, color: AppColors.black.withOpacity(0.3))),
      child: (haveIcon)
          ? Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon ?? SizedBox(),
                SizedBox(
                  width: 8,
                ),
                commonText(
                  text,
                  size: fontSize,
                  color: textColor,
                  isBold: true,
                  textAlign: TextAlign.center,
                ),
              ],
            )
          : commonText(
              text,
              size: 12.0,
              color: textColor,
              isBold: true,
              textAlign: TextAlign.center,
            ),
    ),
  );
}

// Widget commonBorderButton(
//   String title, {
//   double width = double.infinity,
//   double height = 50,
//   VoidCallback? onTap,
//   Color? color,
//   String? imagePath,
//   Widget? icon,
//   double imageSize = 20.0,
//   Color textColor = AppColors.black,
// }) {
//   return GestureDetector(
//     onTap: onTap,
//     child: Container(
//       height: height,
//       width: width,
//       decoration: BoxDecoration(
//         color: (color != null) ? color : null,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       padding: const EdgeInsets.all(1.5), // space for the gradient border
//       child: Container(
//         decoration: BoxDecoration(
//           color: AppColors.white, // inner background color
//           borderRadius: BorderRadius.circular(14), // slightly smaller radius
//         ),
//         child: Center(
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (imagePath != null) ...[
//                 Image.asset(
//                   imagePath,
//                   height: imageSize,
//                   width: imageSize,
//                   fit: BoxFit.contain,
//                 ),
//                 const SizedBox(width: 8),
//               ],
//               if (icon != null) ...[icon, const SizedBox(width: 8)],
//               commonText(title, size: 18, color: textColor, isBold: true),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }

Widget buildOTPTextField(
  TextEditingController controller,
  int index,
  BuildContext context,
) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFFFBE7E5),
        border: Border.all(width: 2, color: AppColors.primary)),
    width: 45,
    height: 60,
    child: TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      cursorColor: Colors.black,
      style: const TextStyle(fontSize: 20),
      maxLength: 1,
      decoration: InputDecoration(
        counterText: '',
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: (value) {
        if (value.length == 1 && index < 5) {
          FocusScope.of(context).nextFocus();
        } else if (value.isEmpty && index > 0) {
          FocusScope.of(context).previousFocus();
        }
      },
    ),
  );
}

Widget commonSearchBar(
    {String hintText = "Search",
    TextEditingController? controller,
    Function(String)? onSubmitted,
    Function(String)? onChanged,
    bool noshadow = false}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: AppColors.primary, width: 2),
      boxShadow: [
        if (!noshadow)
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
      ],
    ),
    child: Row(
      children: [
        Icon(Icons.search, color: AppColors.primary),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            onChanged: onChanged,
            controller: controller,
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    ),
  );
}

// Widget commonRadioGroup(
//   String group,
//   List<String> values,
//   String selectedValue,
//   Function(String) onChanged, {
//   int crossAxisCount = 2,
//   bool alignCenter = false,
//   double childRatio = 4.0,
//   Map<String, Widget>? conditionalWidgets, // <-- NEW
// }) {
//   final showExtra = (String val) {
//     return conditionalWidgets != null && conditionalWidgets.containsKey(val);
//   };
//   if (crossAxisCount == 1) {
//     return Column(
//       children: values.map((val) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Radio<String>(
//                   value: val,
//                   groupValue: selectedValue,
//                   onChanged: (newVal) => onChanged(newVal!),
//                   activeColor: AppColors.yellow,
//                 ),
//                 Flexible(child: commonText(val, size: 14)),
//               ],
//             ),
//             if (selectedValue == val && showExtra(val))
//               Padding(
//                 padding: const EdgeInsets.only(left: 40, bottom: 12),
//                 child: conditionalWidgets![val]!,
//               ),
//           ],
//         );
//       }).toList(),
//     );
//   }
//   if (alignCenter) {
//     return Wrap(
//       spacing: 12,
//       runSpacing: 8,
//       alignment: WrapAlignment.center,
//       children: values.map((val) {
//         return IntrinsicWidth(
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Radio<String>(
//                 value: val,
//                 groupValue: selectedValue,
//                 onChanged: (newVal) => onChanged(newVal!),
//                 activeColor: AppColors.yellow,
//               ),
//               Flexible(child: commonText(val, size: 14)),
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }
//   return GridView.count(
//     crossAxisCount: crossAxisCount,
//     shrinkWrap: true,
//     physics: const NeverScrollableScrollPhysics(),
//     childAspectRatio: childRatio,
//     children: values.map((val) {
//       return Align(
//         alignment: Alignment.centerLeft,
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Radio<String>(
//               value: val,
//               groupValue: selectedValue,
//               onChanged: (newVal) => onChanged(newVal!),
//               activeColor: AppColors.yellow,
//             ),
//             Flexible(child: commonText(val, size: 14)),
//           ],
//         ),
//       );
//     }).toList(),
//   );
// }

Widget commonCheckbox({
  required bool value,
  required Function(bool?) onChanged,
  String label = '',
}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Checkbox(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: const BorderSide(color: Colors.black26),
      ),
      if (label.isNotEmpty) Flexible(child: commonText(label, size: 14)),
    ],
  );
}

Widget commonDropdown<T>({
  required List<T> items,
  required T? value,
  required String hint,
  required void Function(T?) onChanged,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: DropdownButton<T>(
      isExpanded: true,
      underline: SizedBox(),
      value: value,
      hint: commonText(hint, size: 14),
      items: items.map<DropdownMenuItem<T>>((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: commonText(item.toString(), size: 14),
        );
      }).toList(),
      onChanged: onChanged,
    ),
  );
}
