import 'package:firebase_auth/firebase_auth.dart';
import 'package:pops/services/database.dart';
import 'package:pops/models/user_model.dart';

// use this class to control the account
// for example, sign in, sign out, sign up
class AccountManager {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static Future<UsersModel> get currentUser async =>
      await UsersDatabase.queryUser(_auth.currentUser!.uid);

  static Future<void> updateCurrentUser(UsersModel user) async {
    user.id = _auth.currentUser!.uid;
    UsersDatabase.updateUser(user);
  }

  static Future<void> signIn(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;
      if (user == null) {
        signOut();
        throw Exception('User is null');
      }

      if (!user.emailVerified) {
        // resend the verification email
        user.sendEmailVerification();
        signOut();
        throw Exception('Email is not verified');
      }
    } catch (e) {
      signOut();
      rethrow;
    }

    _auth.currentUser!.reload();

    try {
      await UsersDatabase.queryUser(_auth.currentUser!.uid);
    } catch (e) {
      await UsersDatabase.addUser(UsersModel(
        id: _auth.currentUser!.uid,
        name: _auth.currentUser!.displayName!,
        email: _auth.currentUser!.email!,
      ));
    }
  }

  static Future<void> signUp(String name, String email, String password,
      String confirmPassword) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;
      user?.updateDisplayName(name);
      user!.sendEmailVerification();
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Future<String> sendSms(String phone) async {
    String verificationId = '';
    // get the verification id

    // transform the phone number to the E.164
    String phoneE164 = phone;
    if (phoneE164[0] == '0') {
      phoneE164 = '+886${phoneE164.substring(1)}';
    }

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneE164,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          throw Exception('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = verificationId;
      },
    );

    return verificationId;
  }

  static Future<void> verifyPhoneNumber(
      String verificationId, String smsCode) async {
    try {
      await _auth.currentUser!.updatePhoneNumber(PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      ));
      await _auth.currentUser!.reload();
      var user = await AccountManager.currentUser;
      if (_auth.currentUser!.phoneNumber != null) {
        user.phone = _auth.currentUser!.phoneNumber!;
        user.isPhoneVerified = true;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> verifyPassword(String password) async {
    try {
      await _auth.currentUser!.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: _auth.currentUser!.email!,
          password: password,
        ),
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<void> resetPasswordBySendEmail(String email) async {
    if (email.isEmpty) {
      throw Exception('Email is required');
    }

    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> resetPassword(String password) async {
    try {
      await _auth.currentUser!.updatePassword(password);
      await _auth.currentUser!.reload();
    } catch (e) {
      rethrow;
    }
  }

  static deleteAccount() async {
    try {
      UsersDatabase.deleteUser(_auth.currentUser!.uid);
      await _auth.currentUser!.delete();
      await _auth.currentUser!.reload();
    } catch (e) {
      rethrow;
    }
  }

  static bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  static bool isPhoneVerified() {
    return _auth.currentUser!.phoneNumber != "";
  }
}
