import 'package:booking_app/common/colors.dart';
import 'package:booking_app/common/enums.dart';
import 'package:booking_app/common/images.dart';
import 'package:booking_app/common/text_style_extension.dart';
import 'package:booking_app/data/bloc/event/seat_selection_event.dart';
import 'package:booking_app/data/bloc/provider/seat_selection_bloc.dart';
import 'package:booking_app/data/bloc/state/seat_selection_state.dart';
import 'package:booking_app/data/repo/entities/family_data.dart';
import 'package:booking_app/ui/common/common_button.dart';
import 'package:booking_app/ui/common/empty_view.dart';
import 'package:booking_app/ui/common/seat_indication.dart';
import 'package:booking_app/ui/seatselection/helper/model/seat_info.dart';
import 'package:booking_app/ui/seatselection/helper/seat/seat_data_helper.dart';
import 'package:booking_app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SeatLayout extends StatefulWidget {
  final FamilyData familyData;
  final Function(List<SeatInfo> selectedSeats) onComplete;

  const SeatLayout({
    Key? key,
    required this.onComplete,
    required this.familyData,
  }) : super(key: key);

  @override
  _SeatLayoutState createState() => _SeatLayoutState();
}

class _SeatLayoutState extends State<SeatLayout> {
  late SeatSelectionBloc _seatSelectionBloc;

  SeatRows? seatRows;

  double seatSize = 30;
  List<SeatInfo> selectedSeatsList = [];

  @override
  void initState() {
    super.initState();
    _seatSelectionBloc = SeatSelectionBloc();
    _seatSelectionBloc.add(GetSeatsEvent());
  }

  void setSeatSize(int columnCount) {
    Size size = MediaQuery.of(context).size;
    // Where 24 => extra space pix (padding left-right)
    var padding = 24;
    // column count including without padding
    var maxColumnCount = columnCount + (columnCount / 3).floor();
    seatSize = (size.width - padding * 2) / maxColumnCount;
  }

  Color getSeatColor(SeatState state) {
    switch (state) {
      case SeatState.selected:
        return AppColors.orange;
      case SeatState.occupied:
        return AppColors.grey;
      case SeatState.available:
      default:
        return AppColors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    setSeatSize(5);
    return Column(
      children: [
        SizedBox(height: 16.h),
        Wrap(
          alignment: WrapAlignment.spaceAround,
          children: [
            SeatIndication(
              child: seatUI(SeatInfo(seatState: SeatState.occupied)),
              seatState: SeatState.occupied,
            ),
            SeatIndication(
              child: seatUI(SeatInfo(seatState: SeatState.available)),
              seatState: SeatState.available,
            ),
            SeatIndication(
              child: seatUI(SeatInfo(seatState: SeatState.selected)),
              seatState: SeatState.selected,
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Text(
          'All eyes this way please!',
          style: Theme.of(context)
              .textTheme
              .text16()
              .copyWith(color: AppColors.textColorDark),
        ),
        const Divider(
          color: AppColors.primaryColorDark,
        ),
        SizedBox(height: 48.h),
        BlocBuilder(
          bloc: _seatSelectionBloc,
          builder: (context, state) {
            if (state is SeatDataStateComplete) {
              seatRows = state.data;
            } else if (state is SeatDataStateError) {
              return const EmptyView(
                message: 'Unable to load seats, Please try later',
              );
            }

            if (seatRows == null) {
              return const SizedBox();
            }
            return ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, position) {
                int rowNo = position + 1;
                var row = seatRows?.rows[rowNo];
                var nextRow = seatRows?.rows['${rowNo + 1}'];
                if (row == null) {
                  return const SizedBox();
                }
                if (row.first.rowName != nextRow?.first.rowName) {
                  return SizedBox(height: 5.h);
                }
                return const SizedBox();
              },
              itemCount: seatRows?.rows.length ?? 0,
              itemBuilder: (context, position) {
                var rowNum = position + 1;
                var row = seatRows?.rows[rowNum];
                if (row == null) {
                  return const SizedBox();
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: seatSize,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...List.generate(
                            row.length,
                            (index) {
                              SeatInfo seat = row[index];

                              return GestureDetector(
                                onTap: () {
                                  if (seat.isBooked()) {
                                    AppUtils.instance
                                        .showToast('This seat is occupied');
                                  } else {
                                    SeatRows? seats = seatRows;
                                    if (seats != null) {
                                      SeatRows updatedSeats = SeatDataHelper
                                          .instance
                                          .validateSeatSelection(
                                        seat: seat,
                                        seatRows: seats,
                                        selectedSeatsList: selectedSeatsList,
                                        totalRequiredSeats:
                                            widget.familyData.totalMembers,
                                      );
                                      _seatSelectionBloc.add(SelectSeatEvent(
                                          updatedSeats: updatedSeats));
                                    }
                                  }
                                },
                                child: Container(
                                  height: seatSize * 1.1,
                                  width: seatSize,
                                  margin: const EdgeInsets.all(1.0),
                                  child: seatUI(seat),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    )
                  ],
                );
              },
            );
          },
        ),
        const Spacer(),
        CommonButton(
          onTap: () {
            if (selectedSeatsList.isNotEmpty) {
              widget.onComplete(selectedSeatsList);
            } else {
              AppUtils.instance.showToast('Please select seats');
            }
          },
        ),
      ],
    );
  }

  Widget seatUI(SeatInfo seat) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Stack(
          children: [
            SvgPicture.asset(
              AppImages.kSeat,
              color: Colors.black54,
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                    color: getSeatColor(seat.seatState ?? SeatState.available)
                        .withOpacity(0.7),
                    borderRadius: BorderRadius.circular(4.0)),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                seat.seatNo ?? '',
                style: Theme.of(context).textTheme.text16().copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColorDark),
              ),
            )
          ],
        ),
      ),
    );
  }
}
