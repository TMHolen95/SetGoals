import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class Auth {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseUser firebaseUser;

  static FacebookLogin _facebookLogin = FacebookLogin();
  static GoogleSignIn _googleSignIn = GoogleSignIn();

  static Stream<FirebaseUser> authStateChange() {
    return _auth.onAuthStateChanged;
  }

  static Future<bool> loginFacebook() async {
    try {
      FacebookLoginResult fbLoginRes = await _facebookLogin
          .logInWithReadPermissions(['email', 'public_profile']);

      switch (fbLoginRes.status) {
        case FacebookLoginStatus.loggedIn:
          AuthCredential credential = FacebookAuthProvider.getCredential(
              accessToken: fbLoginRes.accessToken.token);
          firebaseUser = await _auth.signInWithCredential(credential);
          return firebaseUser != null;
        case FacebookLoginStatus.cancelledByUser:
          return false;
        case FacebookLoginStatus.error:
          return false;
        default:
          return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> loginGoogle() async {
    try {
      GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
      if (_googleUser != null) {
        GoogleSignInAuthentication _googleAuth =
            await _googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.getCredential(
            idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);
        firebaseUser = await _auth.signInWithCredential(credential);
        return firebaseUser != null;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  static void logout() async {
    _auth.signOut();
    firebaseUser = null;
    _facebookLogin.logOut();
    _googleSignIn.signOut();
  }

  static FirebaseUser user() {
    return firebaseUser;
  }

  static Future<FirebaseUser> getCurrentUser() async {
    firebaseUser = await _auth.currentUser();

    return firebaseUser;
  }

  static Future<bool> loginExistingEmailAccount(
      String email, String password) async {
    try {
      firebaseUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return firebaseUser != null;
    } catch (e) {
      print("Firebase exception:\n$e");
      return false;
    }
  }

  static Future<bool> loginNewEmailAccount(
      String email, String password) async {
    firebaseUser = await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .catchError((error) {
          print(error);
    });
    return firebaseUser != null;
  }

  static Future<bool> handlePasswordRecovery(String email) async {
    try {
      bool res = false;
      await _auth
          .sendPasswordResetEmail(email: email)
          .then((val) => res = true)
          .catchError(() => res = false);
      return res;
    } catch (e) {
      print("Firebase exception:\n$e");
      return false;
    }
  }
}
