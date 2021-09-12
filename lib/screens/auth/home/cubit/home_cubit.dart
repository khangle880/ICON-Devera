import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';
import 'package:icon/models/firebase_user_info.dart';
import 'package:icon/models/transfer.dart';
import 'package:icon/repositories/user_repository.dart';
import 'package:icon/screens/components/process_state.dart';

class HomeCubit extends Cubit<ProcessState> {
  HomeCubit(this.userRepository) : super(ProcessInitial());

  final UserRepository userRepository;

  FirebaseUserInfo? userInfo;
  Balance? balance;
  StreamSubscription? _subscription;

  Future<void> loadUserInfo() async {
    emit(Processing());
    _subscription?.cancel();
    _subscription = userRepository.getUserInfo().listen((data) async {
      userInfo = data;
      if (data != null) {
        balance = await FlutterIconNetwork.instance!
            .getIcxBalance(privateKey: data.privateKey);
      }
      updateUserInfo();
    });
  }

  void updateUserInfo() {
    emit(ProcessSuccess());
    emit(ProcessInitial());
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
