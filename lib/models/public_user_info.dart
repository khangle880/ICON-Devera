import 'firestore_doc.dart';

class PublicInfo extends FirestoreDoc {
  final String firstName;
  final String lastName;
  final String email;
  final String walletAddress;

  const PublicInfo({
    required String id,
    required this.email,
    required bool status,
    required this.firstName,
    required this.lastName,
    required this.walletAddress,
  }) : super(id, status);

  factory PublicInfo.fromJson(Map<String, dynamic> json) => PublicInfo(
        id: json['id'] as String,
        email: json['email'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        status: json['status'] as bool,
        walletAddress: json['walletAddress'] as String,
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'status': status,
      'walletAddress': walletAddress
    };
  }

  @override
  List<Object?> get props => [id, email, firstName, lastName, walletAddress];

  @override
  String toString() => '$id $firstName $email $lastName $walletAddress';
}
