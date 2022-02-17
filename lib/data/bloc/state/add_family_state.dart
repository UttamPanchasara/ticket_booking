import 'package:booking_app/network/app_exception.dart';
import 'package:equatable/equatable.dart';

abstract class AddFamilyState<T> extends Equatable {
  final T data;

  const AddFamilyState(this.data);

  @override
  List<Object?> get props => [data];
}

class InitialState extends AddFamilyState {
  const InitialState(data) : super(data);
}

class CreateFamilyStateComplete extends AddFamilyState {
  const CreateFamilyStateComplete(data) : super(data);

  @override
  List<Object?> get props => [data];
}

class CreateFamilyStateLoading extends AddFamilyState<String> {
  const CreateFamilyStateLoading(String data) : super(data);
}

class CreateFamilyStateError extends AddFamilyState<AppException> {
  const CreateFamilyStateError(data) : super(data);
}
