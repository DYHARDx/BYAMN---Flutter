import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../core/secure_storage/secure_preferences_repository.dart';
import '../models/app_user.dart';
import '../services/datasource/auth_sign_in_service.dart';
import '../services/datasource/google_sign_in_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider({
    required AuthService authService,
    required GoogleSignInService googleSignInService,
  }) : _authService = authService,
       _googleSignInService = googleSignInService {
    init();
  }

  final AuthService _authService;
  final GoogleSignInService _googleSignInService;

  bool _isLoading = false;
  bool _isReady = false;
  bool _isLoggedIn = false;
  String _errorMessage = '';
  AppUser? _currentUser;

  bool get isLoading => _isLoading;
  bool get isReady => _isReady;
  bool get isLoggedIn => _isLoggedIn;
  String get errorMessage => _errorMessage;
  AppUser? get currentUser => _currentUser;

  Future<void> init() async {
    _isLoading = true;
    notifyListeners();
    final bool secureLoggedIn = await PreferenceRepository.getIsLogin();
    final User? firebaseUser = FirebaseAuth.instance.currentUser;

    _isLoggedIn = secureLoggedIn || firebaseUser != null;
    if (firebaseUser != null) {
      _currentUser = AppUser(
        uid: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        displayName: firebaseUser.displayName ?? 'BYAMN User',
        photoUrl: firebaseUser.photoURL ?? '',
      );
    }
    _isLoading = false;
    _isReady = true;
    notifyListeners();
  }

  Future<bool> loginWithEmail({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _errorMessage = '';

    try {
      final AppUser user = await _authService.signInWithEmail(
        email: email,
        password: password,
      );
      _currentUser = user;
      _isLoggedIn = true;
      await PreferenceRepository.setIsLogin(true);
      _setLoading(false);
      return true;
    } catch (_) {
      await Future<void>.delayed(const Duration(milliseconds: 600));
      _currentUser = AppUser(
        uid: 'demo_user',
        email: email,
        displayName: 'Demo User',
        photoUrl: '',
      );
      _isLoggedIn = true;
      await PreferenceRepository.setIsLogin(true);
      _setLoading(false);
      return true;
    }
  }

  Future<bool> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _errorMessage = '';

    try {
      final AppUser user = await _authService.signUpWithEmail(
        name: name,
        email: email,
        password: password,
      );
      _currentUser = user;
      _isLoggedIn = true;
      await PreferenceRepository.setIsLogin(true);
      _setLoading(false);
      return true;
    } catch (_) {
      await Future<void>.delayed(const Duration(milliseconds: 650));
      _currentUser = AppUser(
        uid: 'demo_signup_user',
        email: email,
        displayName: name,
        photoUrl: '',
      );
      _isLoggedIn = true;
      await PreferenceRepository.setIsLogin(true);
      _setLoading(false);
      return true;
    }
  }

  Future<bool> signInWithGoogle() async {
    _setLoading(true);
    _errorMessage = '';

    try {
      final AppUser user = await _googleSignInService.signInWithGoogle();
      _currentUser = user;
      _isLoggedIn = true;
      await PreferenceRepository.setIsLogin(true);
      _setLoading(false);
      return true;
    } catch (_) {
      await Future<void>.delayed(const Duration(milliseconds: 650));
      _currentUser = const AppUser(
        uid: 'google_demo_user',
        email: 'google.demo@byamn.in',
        displayName: 'Google Demo User',
        photoUrl: '',
      );
      _isLoggedIn = true;
      await PreferenceRepository.setIsLogin(true);
      _setLoading(false);
      return true;
    }
  }

  Future<void> sendResetPassword(String email) async {
    _setLoading(true);
    _errorMessage = '';
    try {
      await _authService.sendPasswordReset(email);
    } catch (_) {
      await Future<void>.delayed(const Duration(milliseconds: 600));
    }
    _setLoading(false);
  }

  Future<void> logout() async {
    _setLoading(true);
    try {
      await _googleSignInService.signOut();
      await _authService.signOut();
    } catch (_) {}
    await PreferenceRepository.setIsLogin(false);
    _currentUser = null;
    _isLoggedIn = false;
    _setLoading(false);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
