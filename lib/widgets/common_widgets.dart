import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';

Widget textWidget({
  required String text,
  FontWeight fontWeight = FontWeight.normal,
  double fontSize = 14,
  Color color = Colors.black,
}) {
  return Text(
    text,
    style: TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight),
  );
}

Widget cartButton({
  required String text,
  double? width,
  double? height,
  required VoidCallback onTap,
}) {
  return MaterialButton(
    minWidth: width ?? Get.width,
    height: height ?? 44,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    onPressed: onTap,
    color: AppColors.primaryColor,
    child: textWidget(
        color: Colors.white, text: text, fontWeight: FontWeight.w600),
  );
}
