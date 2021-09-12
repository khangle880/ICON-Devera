part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class EmailOnChange extends SignInEvent {
  final String email;
  const EmailOnChange({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}

class PasswordOnChange extends SignInEvent {
  final String password;
  const PasswordOnChange({
    required this.password,
  });

  @override
  List<Object> get props => [password];
}

class PinVerify extends SignInEvent {
  final String pin;
  const PinVerify({
    required this.pin,
  });

  @override
  List<Object> get props => [pin];
}

class SubmitLogin extends SignInEvent {}
