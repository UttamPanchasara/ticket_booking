import 'package:booking_app/data/bloc/event/add_member_event.dart';
import 'package:booking_app/data/bloc/provider/add_member_bloc.dart';
import 'package:booking_app/data/bloc/state/add_member_state.dart';
import 'package:booking_app/data/repo/entities/family_data.dart';
import 'package:booking_app/utils/app_utils.dart';
import 'package:booking_app/utils/logs_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'detail_form.dart';
import '../model/seat_info.dart';

class MemberDetails extends StatefulWidget {
  final List<SeatInfo> selectedSeatsList;
  final FamilyData familyData;
  final Function onComplete;

  const MemberDetails({
    Key? key,
    required this.selectedSeatsList,
    required this.onComplete,
    required this.familyData,
  }) : super(key: key);

  @override
  _MemberDetailsState createState() => _MemberDetailsState();
}

class _MemberDetailsState extends State<MemberDetails> {
  final PageController _pageController = PageController();
  late AddMemberBloc _addMemberBloc;

  List<SeatInfo> selectedSeatsList = [];
  List<Members> membersList = [];

  bool updatingDetails = false;

  @override
  void initState() {
    super.initState();
    _addMemberBloc = AddMemberBloc();
    selectedSeatsList.addAll(widget.selectedSeatsList);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener(
          bloc: _addMemberBloc,
          listener: (context, state) {
            if (state is AddMembersStateLoading) {
              updatingDetails = true;
            } else {
              updatingDetails = false;
              if (state is AddMembersStateError) {
                AppUtils.instance
                    .showToast('Something went wrong, Please try again');
              } else if (state is AddMembersStateComplete) {
                AppUtils.instance.showToast('Your booking is completed!!');
              }
              widget.onComplete();
            }
          },
          child: PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, pageIndex) {
              bool isLastMember = pageIndex == (selectedSeatsList.length - 1);
              SeatInfo seatInfo = selectedSeatsList[pageIndex];
              return DetailForm(
                memberDetail: getMember(seatInfo.seatNo),
                seatInfo: seatInfo,
                onBack: () {
                  if (!updatingDetails) {
                    _pageController.jumpToPage((pageIndex - 1));
                  }
                },
                isFirstMember: pageIndex == 0,
                isLastMember: isLastMember,
                onNext: (member) {
                  if (!updatingDetails) {
                    updateMemberList(member);
                    if (isLastMember) {
                      LogsUtil.instance.printLog(membersList.length.toString());
                      _addMemberBloc.add(
                        AddMembersEvent(
                            familyData: widget.familyData,
                            members: membersList),
                      );
                    } else {
                      _pageController.jumpToPage((pageIndex + 1));
                    }
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void updateMemberList(Members member) {
    if (membersList.isNotEmpty) {
      membersList.removeWhere((element) => element.seatNo == member.seatNo);
    }
    membersList.add(member);
  }

  Members? getMember(String? seatNo) {
    List<Members> members =
        membersList.where((element) => element.seatNo == seatNo).toList();
    if (members.isNotEmpty) {
      return members.first;
    }

    return null;
  }
}
