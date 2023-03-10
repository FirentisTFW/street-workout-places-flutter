import 'package:app/styles/app_colors.dart';
import 'package:flutter/material.dart';

class AppDecorations {
  const AppDecorations._();

  static final BoxDecoration bottomNavigationBar = BoxDecoration(
    borderRadius: BorderRadius.circular(40.0),
    boxShadow: [
      BoxShadow(
        blurRadius: 10.0,
        color: AppColors.greyDark.withOpacity(0.13),
        spreadRadius: 5.0,
      ),
    ],
    color: Colors.white,
  );

  static final BoxDecoration primaryButton = BoxDecoration(
    borderRadius: BorderRadius.circular(20.0),
    color: AppColors.blue,
  );
}
