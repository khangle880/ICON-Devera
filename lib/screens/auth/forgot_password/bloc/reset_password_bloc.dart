import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:icon/repositories/user_repository.dart';
import 'package:icon/screens/components/process_state.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final UserRepository _userRepository;

  ResetPasswordBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(ResetPasswordState());

  @override
  Stream<ResetPasswordState> mapEventToState(ResetPasswordEvent event) async* {
    if (event is EmailOnChange) {
      yield state.copyWith(email: event.email);
    } else if (event is OtpOnChange) {
      yield state.copyWith(otp: event.otp);
    } else if (event is NewPasswordOnChange) {
      yield state.copyWith(newPassword: event.password);
    } else if (event is ConfirmPasswordOnChange) {
      yield state.copyWith(confirmPassword: event.confirmPassword);
    } else if (event is ResetPassSendRequest) {
      yield* _mapResetPassSendRequestToState();
    } else if (event is VerifyOtp) {
      yield* _mapVerifyOtpToState();
    } else if (event is SubmitNewPassword) {
      yield* _mapSubmitNewPasswordToState();
    }
  }

  Stream<ResetPasswordState> _mapResetPassSendRequestToState() async* {
    yield state.copyWith(sendEmailStatus: Processing());
    final requestStatus =
        await _userRepository.requestResetPassword(state.email);
    if (requestStatus) {
      yield state.copyWith(sendEmailStatus: ProcessSuccess());
      yield state.copyWith(sendEmailStatus: ProcessInitial());
    } else {
      yield state.copyWith(
          sendEmailStatus: ProcessFailure("OTP was not sent failure"));
      yield state.copyWith(sendEmailStatus: ProcessInitial());
    }
  }

  Stream<ResetPasswordState> _mapVerifyOtpToState() async* {
    yield state.copyWith(checkOtpStatus: Processing());
    final verifyStatus = _userRepository.verify(state.email, state.otp);
    if (verifyStatus) {
      yield state.copyWith(checkOtpStatus: ProcessSuccess());
      yield state.copyWith(checkOtpStatus: ProcessInitial());
    } else {
      yield state.copyWith(checkOtpStatus: ProcessFailure("Otp wrong"));
      yield state.copyWith(checkOtpStatus: ProcessInitial());
    }
  }

  Stream<ResetPasswordState> _mapSubmitNewPasswordToState() async* {
    yield state.copyWith(createNewPassStatus: Processing());
    final error = await _userRepository.resetPassword(
        state.email, state.newPassword, state.otp);
    if (error == null) {
      yield state.copyWith(createNewPassStatus: ProcessSuccess());
      yield state.copyWith(createNewPassStatus: ProcessInitial());
    } else {
      yield state.copyWith(createNewPassStatus: ProcessFailure(error));
      yield state.copyWith(createNewPassStatus: ProcessInitial());
    }
  }
}
