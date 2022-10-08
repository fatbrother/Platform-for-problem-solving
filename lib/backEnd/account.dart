import 'package:firebase_auth/firebase_auth.dart';
import 'database/user.dart';

class AccountManager {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User get currentUser => _auth.currentUser!;

  Future<void> signIn(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
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

  Future<void> signUp(String name, String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
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
        userCredential.user!.uid,
        name,
        email,
        '',
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

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> checkSmsCode(String smsCode, String verificationId) async {
    // make a credential with smsCode
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    // sign in with credential
    try {
      await _auth.signInWithCredential(credential);
    } catch (e) {
      rethrow;
    }

    // if sign in is successful then update user phone number
    try {
      await UsersDatabase.updateUser(
        UsersModel(
          currentUser.uid,
          '',
          '',
          currentUser.phoneNumber!,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<String> verifyPhone(String phone) async {
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
}
