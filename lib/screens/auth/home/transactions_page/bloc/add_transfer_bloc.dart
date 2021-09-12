import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';
import 'package:icon/models/transfer.dart';
import 'package:icon/repositories/user_repository.dart';
import 'package:icon/screens/auth/home/cubit/home_cubit.dart';
import 'package:icon/screens/components/process_state.dart';

part 'add_transfer_event.dart';
part 'add_transfer_state.dart';

class AddTransferBloc extends Bloc<AddTransferEvent, AddTransferState> {
  AddTransferBloc({required this.homeCubit, required this.userRepository})
      : super(AddTransferState());

  final HomeCubit homeCubit;
  final UserRepository userRepository;

  @override
  Stream<AddTransferState> mapEventToState(
    AddTransferEvent event,
  ) async* {
    if (event is DestinationOnChange) {
      yield state.copyWith(destination: event.destination);
    } else if (event is AmountOnChange) {
      yield state.copyWith(amount: event.amount);
    } else if (event is AddTransferSubmit) {
      yield* _mapAddTransferSubmitToState();
    }
  }

  Stream<AddTransferState> _mapAddTransferSubmitToState() async* {
    yield state.copyWith(addStatus: Processing());
    if (state.destination == "") {
      yield state.copyWith(
          addStatus: ProcessFailure("Destination can not empty"));
      yield state.copyWith(addStatus: ProcessInitial());
    } else if (state.amount == "" || double.parse(state.amount) == 0.0) {
      yield state.copyWith(
          addStatus: ProcessFailure("Amount Transfer can not zero"));
      yield state.copyWith(addStatus: ProcessInitial());
    } else if (double.parse(state.amount) > homeCubit.balance!.icxBalance) {
      yield state.copyWith(
          addStatus: ProcessFailure("Amount exceed the amount available"));
      yield state.copyWith(addStatus: ProcessInitial());
    } else {
      final txHash = await FlutterIconNetwork.instance!.sendIcx(
          yourPrivateKey: homeCubit.userInfo!.privateKey,
          destinationAddress: state.destination,
          value: state.amount);
      print('Send Success');
      print(txHash.txHash);

      final error = await userRepository.addTransaction(Transfer(
          to: state.destination, txHash: txHash.txHash!, amount: state.amount));

      if (error == null) {
        yield state.copyWith(addStatus: ProcessSuccess());
        yield state.copyWith(addStatus: ProcessInitial());
      } else {
        yield state.copyWith(addStatus: ProcessFailure(error));
        yield state.copyWith(addStatus: ProcessInitial());
      }
    }
  }
}
