import 'package:equatable/equatable.dart';
import 'package:icon/utils/errors/auth_error.dart';

abstract class ProcessState extends Equatable {
  const ProcessState();

  @override
  List<Object?> get props => [];
}

class ProcessInitial extends ProcessState {
  const ProcessInitial();
}

class Processing extends ProcessState {}

class ProcessFailure extends ProcessState {
  late final String errorMessage;
  ProcessFailure(String errorCode) {
    final error = authErrors[errorCode];
    if (error != null) {
      errorMessage = error;
    } else {
      errorMessage = errorCode;
    }
  }

  @override
  List<Object?> get props => [errorMessage];
}

class ProcessSuccess extends ProcessState {}
