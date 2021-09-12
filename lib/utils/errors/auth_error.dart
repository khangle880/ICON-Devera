import 'package:equatable/equatable.dart';

class Error extends Equatable {
  final String errorCode;
  final String errorMessage;

  const Error(this.errorCode, this.errorMessage);

  @override
  List<Object?> get props => [errorCode, errorMessage];
}

class ErrorCode {
  static const String invalidCode = "invalid-code";
  static const String invalidPin = "invalid-Pin";
  static const String userNotFound = "user-not-found";
  static const String userNotLogout = "user-not-logout";
  static const String userNotLogin = "user-not-login";
  static const String passwordSameOld = "password-same-old";
  static const String passwordWrong = "wrong-password";
  static const String invalidEmail = "invalid-email";
  static const String networkRequestFailed = "network-request-failed";
  static const String tooManyRequests = "too-many-requests";
  static const String tooWeakPassword = "weak-password";
  static const String emailAlreadyInUse = "email-already-in-use";
}

final Map<String, String> authErrors = {
  ErrorCode.invalidCode: "Invalid code or expired, please another code.",
  ErrorCode.invalidPin: "Pin entered wrong, please another pin.",
  ErrorCode.invalidEmail: "The email address is badly formatted.",
  ErrorCode.networkRequestFailed: "No internet, please connect to internet.",
  ErrorCode.passwordSameOld: "The new password same as the old password.",
  ErrorCode.passwordWrong: "Wrong password provided for that user.",
  ErrorCode.tooManyRequests: "Please wait a few minutes before you try again.",
  ErrorCode.userNotFound: "No user found for that email.",
  ErrorCode.userNotLogin: "Please log in before doing this.",
  ErrorCode.userNotLogout: "Please log out before doing this.",
  ErrorCode.tooWeakPassword : "The password provided is too weak.",
  ErrorCode.emailAlreadyInUse: "The account already exists for that email.",
};
