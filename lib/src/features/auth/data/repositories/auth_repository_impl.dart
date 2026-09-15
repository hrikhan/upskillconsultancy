import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:upskill_consultancy/src/utils/typedefs.dart';
import 'package:upskill_consultancy/src/features/auth/domain/entities/user.dart';
import 'package:upskill_consultancy/src/features/auth/domain/repositories/auth_repository.dart';

/// Pure mock implementation of [AuthRepository] during UI development.
/// No network or API calls are made. Real Wix API integration will be added later.
class AuthRepositoryImpl implements AuthRepository {
  static const AppUser _defaultMockUser = AppUser(
    id: 'mock_student_1',
    name: 'Hridoy Khan',
    email: 'hridoy@upskillconsultancy.com',
  );

  final StreamController<AppUser?> _authStateController =
      StreamController<AppUser?>.broadcast();
  AppUser? _currentUser = _defaultMockUser;

  AuthRepositoryImpl() {
    _authStateController.add(_currentUser);
  }

  @override
  Stream<AppUser?> get onAuthStateChanged => _authStateController.stream;

  @override
  FutureEither<AppUser> login({
    required String email,
    required String password,
  }) async {
    final user = AppUser(
      id: 'mock_${DateTime.now().millisecondsSinceEpoch}',
      name: email.contains('@') ? email.split('@').first : 'UpSkill Student',
      email: email.isNotEmpty ? email : 'student@upskillconsultancy.com',
    );
    _currentUser = user;
    _authStateController.add(_currentUser);
    return right(user);
  }

  @override
  FutureEither<AppUser> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final user = AppUser(
      id: 'mock_${DateTime.now().millisecondsSinceEpoch}',
      name: name.isNotEmpty ? name : 'UpSkill Student',
      email: email.isNotEmpty ? email : 'student@upskillconsultancy.com',
    );
    _currentUser = user;
    _authStateController.add(_currentUser);
    return right(user);
  }

  @override
  FutureEither<void> forgotPassword({
    required String email,
  }) async {
    return right(null);
  }

  @override
  FutureEither<AppUser?> checkAuthState() async {
    return right(_currentUser ?? _defaultMockUser);
  }

  @override
  FutureEither<void> logout() async {
    _currentUser = null;
    _authStateController.add(null);
    return right(null);
  }
}
