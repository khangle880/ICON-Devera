part of 'reset_password_bloc.dart';

class ResetPasswordState extends Equatable {
  final String email;
  final String otp;
  final String newPassword;
  final String confirmPassword;
  final ProcessState sendEmailStatus;
  final ProcessState checkOtpStatus;
  final ProcessState createNewPassStatus;
  const ResetPasswordState({
    this.email = "",
    this.otp = "",
    this.newPassword = "",
    this.confirmPassword = "",
    this.sendEmailStatus = const ProcessInitial(),
    this.checkOtpStatus = const ProcessInitial(),
    this.createNewPassStatus = const ProcessInitial(),
  });

  @override
  List<Object> get props {
    return [
      email,
      otp,
      newPassword,
      confirmPassword,
      sendEmailStatus,
      checkOtpStatus,
      createNewPassStatus,
    ];
  }

  ResetPasswordState copyWith({
    String? email,
    String? otp,
    String? newPassword,
    String? confirmPassword,
    ProcessState? sendEmailStatus,
    ProcessState? checkOtpStatus,
    ProcessState? createNewPassStatus,
  }) {
    return ResetPasswordState(
      email: email ?? this.email,
      otp: otp ?? this.otp,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      sendEmailStatus: sendEmailStatus ?? this.sendEmailStatus,
      checkOtpStatus: checkOtpStatus ?? this.checkOtpStatus,
      createNewPassStatus: createNewPassStatus ?? this.createNewPassStatus,
    );
  }
}
