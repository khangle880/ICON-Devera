part of 'add_transfer_bloc.dart';

class AddTransferState extends Equatable {
  final String destination;
  final String amount;
  final ProcessState addStatus;
  const AddTransferState({
     this.destination = '',
     this.amount = '',
     this.addStatus = const ProcessInitial(),
  });

  @override
  List<Object> get props => [destination, amount, addStatus];

  AddTransferState copyWith({
    String? destination,
    String? amount,
    ProcessState? addStatus,
  }) {
    return AddTransferState(
      destination: destination ?? this.destination,
      amount: amount ?? this.amount,
      addStatus: addStatus ?? this.addStatus,
    );
  }
}
