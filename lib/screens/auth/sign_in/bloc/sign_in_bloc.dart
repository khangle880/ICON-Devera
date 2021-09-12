import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:icon/repositories/user_repository.dart';
import 'package:icon/screens/components/process_state.dart';
import 'package:icon/screens/section_cubit.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({required this.userRepository, required this.sectionCubit})
      : super(SignInState());

  final UserRepository userRepository;
  final SectionCubit sectionCubit;

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    if (event is EmailOnChange) {
      yield state.copyWith(email: event.email);
    } else if (event is PasswordOnChange) {
      yield state.copyWith(password: event.password);
    } else if (event is SubmitLogin) {
      yield* _mapSubmitLoginToState();
    } else if (event is PinVerify) {
      yield* _mapPinVerifyToState(pin: event.pin);
    }
  }

  Stream<SignInState> _mapSubmitLoginToState() async* {
    yield state.copyWith(submitForm: Processing());
    final String? error =
        await userRepository.signInWithCredentials(state.email, state.password);
    if (error == null) {
      yield state.copyWith(submitForm: ProcessSuccess());
      yield state.copyWith(submitForm: ProcessInitial());
    } else {
      yield state.copyWith(submitForm: ProcessFailure(error));
      yield state.copyWith(submitForm: ProcessInitial());
    }
  }

  Stream<SignInState> _mapPinVerifyToState({required String pin}) async* {
    yield state.copyWith(verifyStatus: Processing());
    final String? error = await userRepository.verifyPin(pin);
    if (error == null) {
      yield state.copyWith(verifyStatus: ProcessSuccess());
      sectionCubit.showHome();
    } else {
      yield state.copyWith(verifyStatus: ProcessFailure(error));
      yield state.copyWith(verifyStatus: ProcessInitial());
    }
  }
}
