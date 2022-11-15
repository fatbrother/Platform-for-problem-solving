import 'package:firebase_auth/firebase_auth.dart';
import '../database.dart';

// use this class to control the account
// for example, sign in, sign out, sign up
class AccountManager {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static UsersModel? currentUser;

  static void updateCurrentUser() async {
    UsersDatabase.updateUser(currentUser!);
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

    try {
      currentUser = await UsersDatabase.queryUser(_auth.currentUser!.uid);
    } catch (e) {
      signOut();
      rethrow;
    }
  }

  static Future<void> signUp(String name, String email, String password, String confirmPassword) async {
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

      final UsersModel usersModel = UsersModel(
        id: userCredential.user!.uid,
        name: name,
        email: email,
      );

      try {
        UsersDatabase.addUser(usersModel);
        currentUser = usersModel;
      } catch (e) {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();

    currentUser = null;
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
        UsersModel? usersModel = currentUser;
        usersModel!.phone = _auth.currentUser!.phoneNumber!;
        UsersDatabase.updateUser(usersModel);
        currentUser = usersModel;
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
    }
    catch (e) {
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
      currentUser = await UsersDatabase.queryUser(_auth.currentUser!.uid);
    } catch (e) {
      rethrow;
    }
  }

  static deleteAccount() async {
    try {
      await _auth.currentUser!.delete();
    } catch (e) {
      rethrow;
    }

    signOut();
    currentUser = null;
  }

  static bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  static bool isEmailVerified() {
    if (!isLoggedIn()) {
      return false;
    }
    return _auth.currentUser!.emailVerified;
  }

  static bool isPhoneVerified() {
    if (!isLoggedIn()) {
      return false;
    }
    return _auth.currentUser!.phoneNumber != null;
  }
}
