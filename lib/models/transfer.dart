
import 'package:equatable/equatable.dart';

class Transfer extends Equatable {
  final String to;
  final String txHash;
  final String amount;
  const Transfer({
    required this.to,
    required this.txHash,
    required this.amount,
  });

  @override
  List<Object> get props => [to, txHash, amount];

  Transfer copyWith({
    String? to,
    String? txHash,
    String? amount,
  }) {
    return Transfer(
      to: to ?? this.to,
      txHash: txHash ?? this.txHash,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'to': to,
      'txHash': txHash,
      'amount': amount,
    };
  }

  factory Transfer.fromJson(Map<String, dynamic> json) {
    return Transfer(
      to: json['to'] as String,
      txHash: json['txHash'] as String,
      amount: json['amount'] as String,
    );
  }
}
