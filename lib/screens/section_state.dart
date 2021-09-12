part of 'section_cubit.dart';

abstract class SectionState extends Equatable {
  const SectionState();

  @override
  List<Object> get props => [];
}

class SectionInitial extends SectionState {}

class Authenticated extends SectionState {
  final User user;

  const Authenticated(this.user);

  @override
  List<Object> get props => [user];
}

class Unauthenticated extends SectionState {}
