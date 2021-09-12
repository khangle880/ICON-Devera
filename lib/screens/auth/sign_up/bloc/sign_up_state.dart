part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final ProcessState createAccountStatus;
  final ProcessState confirmPinStatus;
  const SignUpState({
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.password = "",
    this.createAccountStatus = const ProcessInitial(),
    this.confirmPinStatus = const ProcessInitial(),
  });

  @override
  List<Object> get props {
    return [
      firstName,
      lastName,
      email,
      password,
      createAccountStatus,
      confirmPinStatus,
    ];
  }

  SignUpState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    ProcessState? createAccountStatus,
    ProcessState? createPinStatus,
    ProcessState? confirmPinStatus,
  }) {
    return SignUpState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      createAccountStatus: createAccountStatus ?? this.createAccountStatus,
      confirmPinStatus: confirmPinStatus ?? this.confirmPinStatus,
    );
  }
}
