import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

import '../styles/app_colors.dart';

class CustomAnimatedButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final double buttonWidth;
  final Color bgButtonColor;
  final Color borderColor;
  final Color textColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final double textSize;
  final bool isIconLeft;

  const CustomAnimatedButton({
    required this.bgButtonColor,
    this.isIconLeft = false,
    this.borderColor = AppColors.white,
    this.textColor = AppColors.black,
    this.selectedTextColor = AppColors.white,
    this.unselectedTextColor = AppColors.white,
    this.textSize = 15,
    super.key,
    this.onTap,
    required this.text,
    required this.buttonWidth,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      borderColor: borderColor,
      onPress: onTap,
      width: buttonWidth,
      backgroundColor: bgButtonColor,
      text: text,
      borderRadius: 20,
      animatedOn: AnimatedOn.onHover,
      height: 35,
      selectedGradientColor: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primaryColor,
            AppColors.white,
          ]),
      selectedTextColor: selectedTextColor,
      transitionType: TransitionType.LEFT_BOTTOM_ROUNDER,
      textStyle: TextStyle(
        fontSize: textSize,
        fontFamily: 'HelveticaNeue',
        color: unselectedTextColor,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.visible,
      ),
    );
  }
}
