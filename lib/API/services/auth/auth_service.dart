import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
  /// instance of [AuthService]
  final FirebaseAuth _auth = FirebaseAuth.instance;
  /// get current user
  User? get currentUser => _auth.currentUser;

  /// sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(String email, password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  /// Email and password Sign up
  Future<UserCredential> signUpWithEmailAndPassword(String email, password) async {
    try {
      /// create user with email and password
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  /// sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Google Sign in
  signInWithGoogle() async{
    /// begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    /// if the user cancels the sign in process
    if(gUser == null) return;
    /// obtain the auth details from the request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    /// create a new credential with the token for user
      final  credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      /// Sign in to [Firebase] with the Google Auth credential
      await _auth.signInWithCredential(credential);
  }
  String getErrorMessage(String errorCode){
    switch (errorCode) {
      case 'Exception: user-not-found':
        return 'No user found for that email.';
      case 'Exception: wrong-password':
        return 'Wrong password provided for that user.';
      case 'Exception: email-already-in-use':
        return 'The account already exists for that email.';
      case 'Exception: invalid-email':
        return 'The email address is badly formatted.';
      // ? Should there be a weak password error message?
      case 'Exception: weak-password':
        return 'The password is too weak.';
      default:
        return 'An error occurred';
    }
  }

}