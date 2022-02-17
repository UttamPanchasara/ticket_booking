import 'package:booking_app/network/app_exception.dart';
import 'package:equatable/equatable.dart';

abstract class SeatSelectionState<T> extends Equatable {
  final T data;

  const SeatSelectionState(this.data);

  @override
  List<Object?> get props => [data];
}

class InitialState extends SeatSelectionState {
  const InitialState(data) : super(data);
}

class SeatDataStateLoading extends SeatSelectionState {
  const SeatDataStateLoading(data) : super(data);
}

class SeatDataStateComplete extends SeatSelectionState {
  final DateTime timeStamp;

  const SeatDataStateComplete(data, this.timeStamp) : super(data);

  @override
  List<Object?> get props => [data, timeStamp];
}

class SeatDataStateError extends SeatSelectionState<AppException> {
  const SeatDataStateError(data) : super(data);
}
