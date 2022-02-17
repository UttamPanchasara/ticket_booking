import 'package:booking_app/common/text_style_extension.dart';
import 'package:booking_app/data/repo/entities/family_data.dart';
import 'package:booking_app/ui/seatselection/helper/model/seat_info.dart';
import 'package:booking_app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'helper/memberdetails/member_details.dart';
import 'helper/seat/seat_layout.dart';

class SeatSelectionScreen extends StatefulWidget {
  // The family for which we are booking tickets
  final FamilyData familyData;

  const SeatSelectionScreen({Key? key, required this.familyData})
      : super(key: key);

  @override
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  List<SeatInfo> selectedSeatsList = [];
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            widget.familyData.familyName ?? '',
            style: Theme.of(context)
                .textTheme
                .text22()
                .copyWith(fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: PageView(
                    controller: _pageController,
                    pageSnapping: true,
                    children: [
                      SeatLayout(
                        onComplete: (List<SeatInfo> selectedSeats) {
                          if (selectedSeats.isNotEmpty) {
                            selectedSeatsList.addAll(selectedSeats);
                            _pageController.jumpToPage(1);
                          }
                        },
                        familyData: widget.familyData,
                      ),
                      MemberDetails(
                        selectedSeatsList: selectedSeatsList,
                        familyData: widget.familyData,
                        onComplete: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return AppUtils.instance.showAlertDialog(
        title: 'Cancel Booking?',
        description: 'Are you sure? you want to cancel the booking?',
        positiveText: 'Yes',
        negativeText: 'No',
        context: context,
        onPressed: (value) {
          if (value) {
            Navigator.pop(context);
          }
        });
  }
}
