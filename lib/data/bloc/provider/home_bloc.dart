import 'package:booking_app/data/bloc/event/home_event.dart';
import 'package:booking_app/data/bloc/state/home_state.dart';
import 'package:booking_app/data/repo/entities/family_data.dart';
import 'package:booking_app/data/repo/local_db_repo.dart';
import 'package:booking_app/network/app_exception.dart';
import 'package:booking_app/utils/logs_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LocalDBRepo _dbRepo = LocalDBRepo();

  HomeBloc() : super(const InitialState('')) {
    on<GetFamilyListEvent>(onGetFamilyList);
  }

  Future<void> onGetFamilyList(
      GetFamilyListEvent event, Emitter<HomeState> emit) async {
    emit(const FamilyListStateLoading('Loading'));

    try {
      List<FamilyData> familyList = _dbRepo.getAllFamilies();
      emit(FamilyListStateComplete(familyList));
    } catch (e) {
      LogsUtil.instance.printLog(e.toString());
      emit(FamilyListStateError(AppException('Something went wrong!')));
    }
  }
}
