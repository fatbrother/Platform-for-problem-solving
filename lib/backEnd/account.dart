import 'package:firebase_auth/firebase_auth.dart';
import 'database/database.dart';

// use this class to control the account
// for example, sign in, sign out, sign up
class AccountManager {
  Future<UsersModel?> get currentUser async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      return user == null
          ? throw Exception('Not logged in')
          : await UsersDatabase.queryUser(user.uid);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> signIn(String email, String password) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;
      if (user == null) {
        throw Exception('User is null');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> signUp(String name, String email, String password) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // verify email
      try {
        await userCredential.user!.sendEmailVerification();
      } catch (e) {
        rethrow;
      }

      final UsersModel usersModel = UsersModel(
        id: userCredential.user!.uid,
        name: name,
        email: email,
      );

      UsersDatabase.addUser(usersModel);

      // if verification is successful then sign in
      try {
        await signIn(email, password);
      } catch (e) {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<void> checkSmsCode(
      String smsCode, String verificationId) async {
    // make a credential with smsCode
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    // sign in with credential
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user == null) {
        throw Exception('User is null');
      }
    } catch (e) {
      rethrow;
    }

    // if sign in is successful then update user phone number
    try {
      final usersModel =
          await UsersDatabase.queryUser(FirebaseAuth.instance.currentUser!.uid);
      usersModel.phone = FirebaseAuth.instance.currentUser!.phoneNumber!;
      UsersDatabase.updateUser(usersModel);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> verifyPhone(String phone) async {
    String returnVerificationId = '';

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
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
}
