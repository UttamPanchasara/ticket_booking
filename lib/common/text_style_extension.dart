import 'package:booking_app/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension TextStyleExtension on TextTheme {
  TextStyle text22() {
    return headline6!.copyWith(
      fontSize: 22.sp,
      color: AppColors.textColorDark.withOpacity(0.26),
    );
  }

  TextStyle text16() {
    return subtitle2!.copyWith(
      fontSize: 16.sp,
      color: Colors.black26,
    );
  }

  TextStyle text18() {
    return subtitle2!.copyWith(
      fontSize: 18.sp,
      color: Colors.black26,
    );
  }
}
