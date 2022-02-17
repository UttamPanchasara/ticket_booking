import 'package:booking_app/common/colors.dart';
import 'package:booking_app/common/text_style_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'transparent_background.dart';

class CommonButton extends StatelessWidget {
  final Function onTap;
  final String? buttonText;

  const CommonButton({Key? key, required this.onTap, this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: TransparentBackground(
        bgColor: AppColors.primaryColorDark,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
            child: Center(
              child: Text(
                buttonText ?? 'Continue',
                style: Theme.of(context)
                    .textTheme
                    .text22()
                    .copyWith(fontWeight: FontWeight.w700, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
