import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:news_app_clean_architecture/features/auth/data/models/user.model.dart';

@injectable
class AuthFirebaseService {
  static final _log = Logger('AuthFirebaseService');

  final fb.FirebaseAuth _firebaseAuth = fb.FirebaseAuth.instance;

  Stream<UserModel?> get authStateChanges => _firebaseAuth
      .authStateChanges()
      .map((user) => user != null ? UserModel.fromFirebase(user) : null);

  UserModel? get currentUser {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;
    return UserModel.fromFirebase(user);
  }

  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    _log.info('signInWithEmailAndPassword → email=$email');
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = credential.user;
      if (user == null) {
        throw Exception('User is null after sign in.');
      }
      return UserModel.fromFirebase(user);
    } on fb.FirebaseAuthException catch (e) {
      _log.warning(
          'signInWithEmailAndPassword → FirebaseAuthException: ${e.code}', e);
      throw _handleFirebaseAuthException(e);
    }
  }

  Future<UserModel> createUserWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    _log.info('createUserWithEmailAndPassword → email=$email');
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = credential.user;
      if (user == null) {
        throw Exception('User is null after account creation.');
      }

      if (displayName != null && displayName.trim().isNotEmpty) {
        await user.updateDisplayName(displayName.trim());
        await user.reload();
      }

      final updatedUser = _firebaseAuth.currentUser ?? user;
      return UserModel.fromFirebase(updatedUser);
    } on fb.FirebaseAuthException catch (e) {
      _log.warning(
          'createUserWithEmailAndPassword → FirebaseAuthException: ${e.code}',
          e);
      throw _handleFirebaseAuthException(e);
    }
  }

  Future<void> signOut() async {
    _log.info('signOut');
    await _firebaseAuth.signOut();
  }

  String _handleFirebaseAuthException(fb.FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Invalid credentials. Please check your email and password.';
      case 'email-already-in-use':
        return 'An account already exists for this email.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      default:
        return e.message ?? 'Authentication error occurred (${e.code}).';
    }
  }
}
