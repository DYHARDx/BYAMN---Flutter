import 'package:firebase_auth/firebase_auth.dart';

import '../../models/app_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<AppUser> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    final userCred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = userCred.user!;

    // Check if the user is Google-only
    final isGoogleUser = user.providerData.any(
      (p) => p.providerId == 'google.com',
    );
    if (isGoogleUser) {
      await FirebaseAuth.instance.signOut(); // prevent login
      throw Exception(
        'Account registered via Google Sign-In. Please use Google login.',
      );
    }
    await user.updateDisplayName(name);

    return AppUser.fromJson({
      'uid': userCred.user!.uid,
      'email': userCred.user!.email,
      'displayName': name,
      'photoUrl': userCred.user!.photoURL,
    });
  }

  Future<AppUser> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return AppUser.fromJson({
      'uid': userCredential.user!.uid,
      'email': userCredential.user!.email,
      'displayName': userCredential.user!.displayName,
      'photoUrl': userCredential.user!.photoURL,
    });
  }

  Future<void> sendPasswordReset(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<AppUser?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    return AppUser.fromJson({
      'uid': user.uid,
      'email': user.email,
      'displayName': user.displayName,
      'photoUrl': user.photoURL,
    });
  }
}
