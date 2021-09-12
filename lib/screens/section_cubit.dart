import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:icon/repositories/user_repository.dart';

part 'section_state.dart';

class SectionCubit extends Cubit<SectionState> {
  SectionCubit({required this.userRepository}) : super(SectionInitial()) {
    startAuth();
  }

  final UserRepository userRepository;

  Future<void> startAuth() async {
    final isSignedIn = await userRepository.isSignedIn();
    if (isSignedIn) {
      final firebaseUser = userRepository.getUser();
      print(firebaseUser);
      emit(Authenticated(firebaseUser!));
    } else {
      emit(Unauthenticated());
    }
  }

  void showAuth() {
    emit(Unauthenticated());
  }

  void signOut() {
    if (userRepository.getUser() != null) userRepository.signOut();
    emit(Unauthenticated());
  }

  void showHome() {
    print("showhome");
    emit(Authenticated(userRepository.getUser()!));
  }
}
