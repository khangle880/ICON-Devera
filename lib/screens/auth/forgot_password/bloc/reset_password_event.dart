part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class ResetPassSendRequest extends ResetPasswordEvent {}

class VerifyOtp extends ResetPasswordEvent {}

class SubmitNewPassword extends ResetPasswordEvent {}

class EmailOnChange extends ResetPasswordEvent {
  final String email;
  const EmailOnChange({
    required this.email,
  });
}

class OtpOnChange extends ResetPasswordEvent {
  final String otp;
  const OtpOnChange({
    required this.otp,
  });
}

class NewPasswordOnChange extends ResetPasswordEvent {
  final String password;
  const NewPasswordOnChange({
    required this.password,
  });
}

class ConfirmPasswordOnChange extends ResetPasswordEvent {
  final String confirmPassword;
  const ConfirmPasswordOnChange({
    required this.confirmPassword,
  });
}
