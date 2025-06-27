// ignore_for_file: must_be_immutable

import 'package:buynow/const/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget widget;
  final VoidCallback ontap;
  const CustomButton({super.key, required this.widget, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.circular(30)),
          child: widget,
        ),
      ),
    );
  }
}
