import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';
import 'package:icon/models/public_user_info.dart';
import 'package:icon/models/firebase_user_info.dart';
import 'package:icon/models/transfer.dart';
import 'package:icon/utils/errors/auth_error.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository() : _firebaseAuth = FirebaseAuth.instance;

  Future<String?> signInWithCredentials(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      return e.code.toString();
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> signUp({
    required String email,
    required String password,
    required String pin,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      final wallet = await FlutterIconNetwork.instance!.createWallet;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'email': email,
        'password': password,
        'pin': pin,
        'status': true,
        'address': wallet.address ?? '',
        'privateKey': wallet.privateKey ?? '',
        'transactions': [],
      });

      final info = PublicInfo(
        id: "",
        email: email,
        status: true,
        firstName: firstName,
        lastName: lastName,
        walletAddress: wallet.address ?? '',
      );

      await FirebaseFirestore.instance
          .collection('public_info')
          .doc(userCredential.user!.uid)
          .set(info.toJson());
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      return e.code.toString();
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> updateInfoWithJson(Map<String, dynamic> json) async {
    try {
      await FirebaseFirestore.instance
          .collection('public_info')
          .doc(getUser()!.uid)
          .update(json);
    } catch (e) {
      return e.toString();
    }
  }

  Future<bool> requestResetPassword(String email) async {
    EmailAuth.sessionName = "Reset Password From Aking App";
    return EmailAuth.sendOtp(receiverMail: email);
  }

  bool verify(String email, String otp) {
    return EmailAuth.validate(receiverMail: email, userOTP: otp);
  }

  Future validatePassword(User user, String password) async {
    final credential =
        EmailAuthProvider.credential(email: user.email!, password: password);
    return user.reauthenticateWithCredential(credential);
  }

  Future<String?> updatePassword(String password, String newPassword) async {
    final user = getUser();
    if (user == null) return ErrorCode.userNotFound;
    if (password == newPassword) return ErrorCode.passwordSameOld;
    try {
      await validatePassword(user, password);
      await user.updatePassword(newPassword);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({"password": newPassword});
    } catch (e) {
      return e.toString();
    }
    return null;
  }

  Future<String?> createNewPassword(String username, String newPassword) async {
    // Create an instance of the current user.
    final User? user = getUser();
    if (user != null) {
      if (user.email != username) return ErrorCode.userNotLogout;
    }

    // Login as an admin
    final signInAdminError = await signInWithCredentials(
        dotenv.env['ADMINEMAIL']!, dotenv.env['ADMINPASSWORD']!);
    if (signInAdminError != null) return signInAdminError;

    // Get old password of user
    String? oldPassword;
    String? getOldPasswordError;
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: username)
        .get()
        .then((value) => {
              if (value.size < 1)
                getOldPasswordError = ErrorCode.userNotFound
              else
                oldPassword = value.docs[0]['password'] as String
            });

    // Sign out Admin
    await signOut();

    // Return Error not found user
    if (getOldPasswordError != null || oldPassword == null) {
      return getOldPasswordError;
    }

    // Update password
    final signInUserError = await signInWithCredentials(username, oldPassword!);
    if (signInUserError != null) return signInUserError;

    final String? updatePasswordError =
        await updatePassword(oldPassword!, newPassword);
    await signOut();

    if (updatePasswordError != null) return updatePasswordError;

    return null;
  }

  Future<String?> resetPassword(
      String username, String newPassword, String resetCode) async {
    if (!verify(username, resetCode)) return ErrorCode.invalidCode;
    return createNewPassword(username, newPassword);
  }

  Future<String?> verifyPin(String verifyPin) async {
    String? pin;
    final User? user = getUser();
    if (user == null) return ErrorCode.userNotLogin;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((value) {
      if (value.data() == null) {
        pin = null;
      } else {
        pin = value.data()!['pin'] as String;
      }
    });
    // User haven't pin
    if (pin == null) return "Not Exists Pin";

    // Verify
    if (verifyPin != pin) return ErrorCode.invalidPin;

    return null;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  User? getUser() {
    return _firebaseAuth.currentUser;
  }

  // get user info
  Stream<FirebaseUserInfo?> getUserInfo() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(getUser()!.uid)
        .snapshots()
        .map((snapshot) {
      final data = snapshot.data();
      if (data == null) return null;
      data['id'] = snapshot.id;
      return FirebaseUserInfo.fromJson(data);
    });
  }

  Future<String?> addTransaction(Transfer transfer) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(getUser()!.uid)
          .update({
        "transactions": FieldValue.arrayUnion([transfer.toJson()])
      });
      return null;
    } on FirebaseException catch (e) {
      return e.code.toString();
    } catch (e) {
      return e.toString();
    }
  }
}
