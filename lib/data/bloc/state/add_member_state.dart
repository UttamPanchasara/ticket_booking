import 'package:booking_app/network/app_exception.dart';
import 'package:equatable/equatable.dart';

abstract class AddMemberState<T> extends Equatable {
  final T data;

  const AddMemberState(this.data);

  @override
  List<Object?> get props => [data];
}

class InitialState extends AddMemberState {
  const InitialState(data) : super(data);
}

class AddMembersStateComplete extends AddMemberState {
  const AddMembersStateComplete(data) : super(data);

  @override
  List<Object?> get props => [data];
}

class AddMembersStateLoading extends AddMemberState<String> {
  const AddMembersStateLoading(String data) : super(data);
}

class AddMembersStateError extends AddMemberState<AppException> {
  const AddMembersStateError(data) : super(data);
}
