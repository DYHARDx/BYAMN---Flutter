import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:byamn/core/logs/app_logs.dart';

import '../../models/app_user.dart';

// Google Sign-In Service Class
class GoogleSignInService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static bool _isInitialize = false;

  static Future<void> _initSignIn() async {
    if (_isInitialize) return;
    await _googleSignIn.initialize(
      serverClientId:
          '899677548911-38akhr0qldqgjhtfbtr2u0ddl1datrfp.apps.googleusercontent.com',
    );
    _isInitialize = true;
  }

  // Sign in with Google
  Future<AppUser> signInWithGoogle() async {
    try {
      await _initSignIn();
      PRINT_LOGS("", "sign in started");
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
      final idToken = googleUser.authentication.idToken;
      final authorizationClient = googleUser.authorizationClient;
      GoogleSignInClientAuthorization? authorization = await authorizationClient
          .authorizationForScopes(['email', 'profile']);
      final accessToken = authorization?.accessToken;
      if (accessToken == null) {
        final authorization2 = await authorizationClient.authorizationForScopes(
          ['email', 'profile'],
        );
        if (authorization2?.accessToken == null) {
          throw FirebaseAuthException(code: "error", message: "error");
        }
        authorization = authorization2;
      }
      final credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user == null) {
        throw FirebaseAuthException(
          code: 'user-null',
          message: 'No user found',
        );
      }

      return AppUser(
        uid: user.uid,
        email: user.email ?? '',
        displayName: user.displayName ?? 'Google User',
        photoUrl: user.photoURL ?? '',
      );
    } catch (e) {
      PRINT_LOGS("", "Google Sign-In error: $e");
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }

  // Get current user

  User? currentUser() => FirebaseAuth.instance.currentUser;
}
