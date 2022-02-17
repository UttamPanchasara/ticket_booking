import 'package:booking_app/common/colors.dart';
import 'package:booking_app/common/text_style_extension.dart';
import 'package:booking_app/data/bloc/event/home_event.dart';
import 'package:booking_app/data/bloc/provider/home_bloc.dart';
import 'package:booking_app/data/bloc/state/home_state.dart';
import 'package:booking_app/data/repo/entities/family_data.dart';
import 'package:booking_app/ui/addfamliy/add_family_screen.dart';
import 'package:booking_app/ui/common/empty_view.dart';
import 'package:booking_app/ui/common/transparent_background.dart';
import 'package:booking_app/ui/seatselection/seat_selection_screen.dart';
import 'package:booking_app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc();
    fetchFamilyList();
  }

  void fetchFamilyList() {
    _homeBloc.add(GetFamilyListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Living Area',
          style: Theme.of(context)
              .textTheme
              .text22()
              .copyWith(fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: SafeArea(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddFamilyScreen()),
                  ).then((value) {
                    fetchFamilyList();
                  });
                },
                child: TransparentBackground(
                  bgColor: AppColors.primaryColorDark,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Add Family',
                          style: Theme.of(context).textTheme.text22().copyWith(
                              fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 32.w,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Flexible(
                flex: 1,
                child: BlocBuilder(
                  bloc: _homeBloc,
                  builder: (context, state) {
                    if (state is FamilyListStateComplete) {
                      List<FamilyData> familyList = state.data;
                      if (familyList.isEmpty) {
                        return emptyFamilyList();
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Text(
                              'Family',
                              style: Theme.of(context)
                                  .textTheme
                                  .text22()
                                  .copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textColorDark),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Flexible(
                            flex: 1,
                            child: ListView.separated(
                              separatorBuilder: (context, position) {
                                return SizedBox(height: 8.h);
                              },
                              shrinkWrap: true,
                              itemCount: familyList.length,
                              itemBuilder: (context, position) {
                                FamilyData data = familyList[position];
                                bool isTicketBooked = data.isTicketBooked();
                                return GestureDetector(
                                  onTap: () {
                                    if (isTicketBooked) {
                                      AppUtils.instance.showToast(
                                          'Ticket Booked for this family');
                                      return;
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SeatSelectionScreen(
                                                  familyData: data)),
                                    ).then((value) {
                                      fetchFamilyList();
                                    });
                                  },
                                  child: TransparentBackground(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8.h, horizontal: 4.w),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${data.familyName ?? ''}, ${data.totalMembers}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .text18()
                                                .copyWith(
                                                    color:
                                                        AppColors.textColorDark),
                                          ),
                                          if (isTicketBooked) ...[
                                            const Icon(
                                              Icons.done_outline,
                                              color: AppColors.green,
                                            )
                                          ]
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }

                    return emptyFamilyList();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget emptyFamilyList() {
    return const EmptyView(
      message: 'Add Family To Book Tickets',
    );
  }
}
