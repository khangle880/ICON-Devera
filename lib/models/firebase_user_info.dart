import 'package:icon/models/transfer.dart';

import 'firestore_doc.dart';

class FirebaseUserInfo extends FirestoreDoc {
  final String email;
  final String address;
  final String privateKey;
  final List<Transfer> transactions;

  const FirebaseUserInfo({
    required String id,
    required bool status,
    required this.email,
    required this.address,
    required this.privateKey,
    required this.transactions,
  }) : super(id, status);

  factory FirebaseUserInfo.fromJson(Map<String, dynamic> json) =>
      FirebaseUserInfo(
        id: json['id'] as String,
        email: json['email'] as String,
        address: json['address'] as String,
        privateKey: json['privateKey'] as String,
        transactions: (json['transactions'] as List)
            .map((item) => Transfer.fromJson(item as Map<String, dynamic>))
            .toList(),
        status: json['status'] as bool,
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'address': address,
      'privateKey': privateKey,
      'status': status,
      'transactions': transactions.map((item) => item.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [id, email, address, privateKey, transactions];

  @override
  String toString() => '$id $address $email $privateKey $transactions';
}
