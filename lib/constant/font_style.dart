

import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppFontStyle {
  //bold.login
  static TextStyle textBlackBold = const TextStyle(
      color: AppColors.black,
      fontSize: 38.00,
      fontFamily: 'inter',
      fontWeight: FontWeight.bold);
  static TextStyle redTextStyle = const TextStyle(
      color: AppColors.red,
      fontSize: 12.00,
      fontFamily: 'inter',
      fontWeight: FontWeight.normal);

  static TextStyle hintTextStyle = const TextStyle(
      color: AppColors.txtGray,
      fontSize: 12.00,
      fontFamily: 'inter',
      fontWeight: FontWeight.normal);

  static TextStyle textBlackMedium14 = const TextStyle(
      color: AppColors.black,
      fontSize: 14.00,
      fontFamily: 'inter',
      fontWeight: FontWeight.w500);
  static TextStyle textWhiteMedium = const TextStyle(
      color: AppColors.white,
      fontSize: 15.00,
      fontFamily: 'inter',
      fontWeight: FontWeight.w500);
  static const black16TextStyle900 = TextStyle(fontWeight: FontWeight.w500,
      color: Colors.black, fontSize: 16);

  static const gray14TextStyle = TextStyle(
      fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.gray);
}
