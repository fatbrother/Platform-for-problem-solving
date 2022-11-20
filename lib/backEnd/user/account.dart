import 'package:firebase_auth/firebase_auth.dart';
import '../database.dart';

// use this class to control the account
// for example, sign in, sign out, sign up
class AccountManager {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static Future<UsersModel> get currentUser async =>
      await UsersDatabase.queryUser(_auth.currentUser!.uid);

  static Future<void> updateCurrentUser(UsersModel user) async {
    user.id = _auth.currentUser!.uid;
    user.email = _auth.currentUser!.email!;
    user.phone = _auth.currentUser!.phoneNumber??'';
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
        signOut();
        throw Exception('Email is not verified');
      }
    } catch (e) {
      signOut();
      rethrow;
    }

    _auth.currentUser!.reload();
  }

  static Future<bool> signUp(String name, String email, String password,
      String confirmPassword) async {
    if (password != confirmPassword) {
      throw Exception('Passwords do not match');
    }

    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;

      user!.sendEmailVerification();

      // wait for the user to verify their email
      // if they don't verify their email, delete the account
      int timer = 0;
      while (!user.emailVerified && timer < 120) {
        await Future.delayed(const Duration(seconds: 1));
        await user.reload();
        timer++;
      }

      if (!user.emailVerified) {
        user.delete();
        throw Exception('Email is not verified');
      }

      await signIn(email, password);
      UsersDatabase.addUser(UsersModel(
        id: user.uid,
        name: name,
        email: email,
      ));
      await _auth.currentUser!.reload();

      return true;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Future<String> sendSms(String phone) async {
    String returnVerificationId = '';

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          throw e;
        },
        codeSent: (String verificationId, int? resendToken) async {
          returnVerificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      rethrow;
    }

    return returnVerificationId;
  }

  static Future<void> verifyPhoneNumber(
      String verificationId, String smsCode) async {
    try {
      _auth.currentUser!.updatePhoneNumber(PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      ));
      try {
        UsersModel? usersModel = await currentUser;
        usersModel.phone = _auth.currentUser!.phoneNumber!;
        UsersDatabase.updateUser(usersModel);
      } catch (e) {
        rethrow;
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
    return _auth.currentUser!.phoneNumber != null;
  }
}
