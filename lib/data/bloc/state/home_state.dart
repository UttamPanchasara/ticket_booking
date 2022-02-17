import 'package:booking_app/network/app_exception.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState<T> extends Equatable {
  final T data;

  const HomeState(this.data);

  @override
  List<Object?> get props => [data];
}

class InitialState extends HomeState {
  const InitialState(data) : super(data);
}

class FamilyListStateComplete extends HomeState {
  const FamilyListStateComplete(data) : super(data);

  @override
  List<Object?> get props => [data];
}

class FamilyListStateLoading extends HomeState<String> {
  const FamilyListStateLoading(String data) : super(data);
}

class FamilyListStateError extends HomeState<AppException> {
  const FamilyListStateError(data) : super(data);
}
