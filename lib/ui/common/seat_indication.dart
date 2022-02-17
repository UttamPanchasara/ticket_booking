import 'package:booking_app/common/colors.dart';
import 'package:booking_app/common/enums.dart';
import 'package:booking_app/common/text_style_extension.dart';
import 'package:flutter/material.dart';

class SeatIndication extends StatelessWidget {
  final SeatState seatState;
  final Widget child;

  const SeatIndication({Key? key, required this.seatState, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          child: child,
          height: 30,
        ),
        Text(
          seatState.name,
          style: Theme.of(context)
              .textTheme
              .text16()
              .copyWith(color: AppColors.textColorDark),
        )
      ],
    );
  }
}
