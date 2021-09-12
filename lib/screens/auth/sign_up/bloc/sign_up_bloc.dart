import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:icon/models/public_user_info.dart';
import 'package:icon/repositories/user_repository.dart';
import 'package:icon/screens/components/process_state.dart';
import 'package:icon/screens/section_cubit.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({required this.userRepository, required this.sectionCubit})
      : super(SignUpState());

  final UserRepository userRepository;
  final SectionCubit sectionCubit;

  String createPin = "";

  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    if (event is EmailOnChange) {
      yield state.copyWith(email: event.email);
    } else if (event is PasswordOnChange) {
      yield state.copyWith(password: event.password);
    } else if (event is FirstNameOnChange) {
      yield state.copyWith(firstName: event.firstName);
    } else if (event is LastNameOnChange) {
      yield state.copyWith(lastName: event.lastName);
    } else if (event is SignUpSubmit) {
      yield* _mapSignUpSubmitToState();
    } else if (event is CreatePinSubmit) {
      createPin = event.pin;
    } else if (event is ConfirmPinSubmit) {
      yield* _mapConfirmPinToState(pin: event.pin);
    }
  }

  Stream<SignUpState> _mapConfirmPinToState({required String pin}) async* {
    yield state.copyWith(confirmPinStatus: Processing());
    if (createPin != pin) {
      yield state.copyWith(
          confirmPinStatus: ProcessFailure("Confirm pin wrong"));
      yield state.copyWith(confirmPinStatus: ProcessInitial());
    } else {
      yield state.copyWith(confirmPinStatus: ProcessSuccess());
      yield state.copyWith(confirmPinStatus: ProcessInitial());
    }
  }

  Stream<SignUpState> _mapSignUpSubmitToState() async* {
    yield state.copyWith(createAccountStatus: Processing());
    final String? error = await userRepository.signUp(
      email: state.email,
      password: state.password,
      firstName: state.firstName,
      lastName: state.lastName,
      
      pin: createPin,
    );
    if (error == null) {
      yield state.copyWith(createAccountStatus: ProcessSuccess());
      sectionCubit.showHome();
    } else {
      yield state.copyWith(createAccountStatus: ProcessFailure(error));
      yield state.copyWith(createAccountStatus: ProcessInitial());
    }
  }
}
