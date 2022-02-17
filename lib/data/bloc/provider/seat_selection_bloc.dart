import 'package:booking_app/data/bloc/event/seat_selection_event.dart';
import 'package:booking_app/data/bloc/state/seat_selection_state.dart';
import 'package:booking_app/data/repo/entities/family_data.dart';
import 'package:booking_app/data/repo/local_db_repo.dart';
import 'package:booking_app/network/app_exception.dart';
import 'package:booking_app/ui/seatselection/helper/model/seat_info.dart';
import 'package:booking_app/ui/seatselection/helper/seat/seat_data_helper.dart';
import 'package:booking_app/utils/logs_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeatSelectionBloc extends Bloc<SeatSelectionEvent, SeatSelectionState> {
  final LocalDBRepo _dbRepo = LocalDBRepo();
  SeatRows? _seatRows;

  SeatSelectionBloc() : super(const InitialState('')) {
    on<SelectSeatEvent>(onSelectSeat);
    on<GetSeatsEvent>(onGetSeats);
  }

  Future<void> onSelectSeat(
      SelectSeatEvent event, Emitter<SeatSelectionState> emit) async {
    try {
      emit(SeatDataStateComplete(event.updatedSeats, DateTime.now()));
    } catch (e) {
      LogsUtil.instance.printLog(e.toString());
      emit(SeatDataStateError(AppException(e.toString())));
    }
  }

  Future<void> onGetSeats(
      GetSeatsEvent event, Emitter<SeatSelectionState> emit) async {
    emit(const SeatDataStateLoading('Loading'));
    try {
      _seatRows = SeatDataHelper.instance.getSeatsStructure();

      List<FamilyData> familyList = _dbRepo.getTickedBookedFamilies();
      List<Members> members = getBookedMembers(familyList);
      _seatRows = SeatDataHelper.instance
          .prepareSeatsStructure(members: members, seatsRows: _seatRows);
      emit(SeatDataStateComplete(_seatRows, DateTime.now()));
    } catch (e) {
      LogsUtil.instance.printLog(e.toString());
      emit(SeatDataStateError(AppException(e.toString())));
    }
  }

  List<Members> getBookedMembers(List<FamilyData> familyList) {
    if (familyList.isEmpty) return [];

    List<Members> members = [];
    for (var family in familyList) {
      if (family.members.isNotEmpty) {
        members.addAll(family.members);
      }
    }
    return members;
  }
}
