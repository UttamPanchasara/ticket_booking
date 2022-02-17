import 'package:booking_app/data/bloc/event/add_member_event.dart';
import 'package:booking_app/data/bloc/state/add_member_state.dart';
import 'package:booking_app/data/repo/entities/family_data.dart';
import 'package:booking_app/data/repo/local_db_repo.dart';
import 'package:booking_app/network/app_exception.dart';
import 'package:booking_app/utils/logs_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddMemberBloc extends Bloc<AddMemberEvent, AddMemberState> {
  final LocalDBRepo _dbRepo = LocalDBRepo();

  AddMemberBloc() : super(const InitialState('')) {
    on<AddMembersEvent>(onAddMembers);
  }

  Future<void> onAddMembers(
      AddMembersEvent event, Emitter<AddMemberState> emit) async {
    emit(const AddMembersStateLoading('Loading'));

    try {
      FamilyData familyData = event.familyData;
      familyData.members.addAll(event.members);
      familyData.ticketBooked = true;
      int familyId = _dbRepo.putFamily(familyData);
      emit(AddMembersStateComplete(familyId));
    } catch (e) {
      LogsUtil.instance.printLog(e.toString());
      emit(AddMembersStateError(AppException(e.toString())));
    }
  }
}
