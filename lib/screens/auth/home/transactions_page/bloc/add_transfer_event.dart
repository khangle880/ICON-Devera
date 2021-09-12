part of 'add_transfer_bloc.dart';

class AddTransferEvent extends Equatable {
  const AddTransferEvent();

  @override
  List<Object> get props => [];
}

class DestinationOnChange extends AddTransferEvent {
  final String destination;
  const DestinationOnChange({
    required this.destination,
  });
}

class AmountOnChange extends AddTransferEvent {
  final String amount;
  const AmountOnChange({
    required this.amount,
  });
}

class AddTransferSubmit extends AddTransferEvent {}
