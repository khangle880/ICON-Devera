part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  final String email;
  final String password;
  final ProcessState submitForm;
  final ProcessState verifyStatus;

  const SignInState({
    this.email = "",
    this.password = "",
    this.submitForm = const ProcessInitial(),
    this.verifyStatus = const ProcessInitial(),
  });

  @override
  List<Object> get props => [email, password, submitForm, verifyStatus];

  SignInState copyWith({
    String? email,
    String? password,
    ProcessState? submitForm,
    ProcessState? verifyStatus,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      submitForm: submitForm ?? this.submitForm,
      verifyStatus: verifyStatus ?? this.verifyStatus,
    );
  }
}
