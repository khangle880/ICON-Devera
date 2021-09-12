part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class FirstNameOnChange extends SignUpEvent {
  final String firstName;
  const FirstNameOnChange({
    required this.firstName,
  });
  @override
  List<Object> get props => [firstName];
}

class LastNameOnChange extends SignUpEvent {
  final String lastName;
  const LastNameOnChange({
    required this.lastName,
  });
  @override
  List<Object> get props => [lastName];
}

class EmailOnChange extends SignUpEvent {
  final String email;
  const EmailOnChange({
    required this.email,
  });
  @override
  List<Object> get props => [email];
}

class PasswordOnChange extends SignUpEvent {
  final String password;
  const PasswordOnChange({
    required this.password,
  });
  @override
  List<Object> get props => [password];
}

class SignUpSubmit extends SignUpEvent {}

class CreatePinSubmit extends SignUpEvent {
  final String pin;
  const CreatePinSubmit({
    required this.pin,
  });
}

class ConfirmPinSubmit extends SignUpEvent {
  final String pin;
  const ConfirmPinSubmit({
    required this.pin,
  });
}
