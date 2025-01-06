import 'package:flutter/material.dart';
import 'package:todo/utils/styles/app_colors.dart';

class KStyles {
//!-----------(light)--------------
  Text light({
    required String text,
    Color color = AppColors.white,
    double? height,
    bool? softWrap,
    required double size,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration? decoration,
    String? fontFamily,
  }) {
    return Text(
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap,
      overflow: overflow,
      text,
      style: TextStyle(
        decoration: TextDecoration.none,
        fontSize: size,
        height: height,
        color: color,
        fontWeight: FontWeight.w200,
      ),
    );
  }
}
