import 'package:booking_app/data/bloc/event/add_family_event.dart';
import 'package:booking_app/data/bloc/state/add_family_state.dart';
import 'package:booking_app/data/repo/local_db_repo.dart';
import 'package:booking_app/network/app_exception.dart';
import 'package:booking_app/utils/logs_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFamilyBloc extends Bloc<AddFamilyEvent, AddFamilyState> {
  final LocalDBRepo _dbRepo = LocalDBRepo();

  AddFamilyBloc() : super(const InitialState('')) {
    on<CreateFamilyEvent>(onCreateFamily);
  }

  Future<void> onCreateFamily(
      CreateFamilyEvent event, Emitter<AddFamilyState> emit) async {
    emit(const CreateFamilyStateLoading('Loading'));

    try {
      int familyId = _dbRepo.putFamily(event.familyData);
      emit(CreateFamilyStateComplete(familyId));
    } catch (e) {
      LogsUtil.instance.printLog(e.toString());
      emit(CreateFamilyStateError(AppException(e.toString())));
    }
  }
}
