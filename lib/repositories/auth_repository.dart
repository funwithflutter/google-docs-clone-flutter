import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone/app/providers.dart';
import 'package:google_docs_clone/repositories/repository_exception.dart';

final _authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepository(ref.read));

class AuthRepository with RepositoryExceptionMixin {
  const AuthRepository(this._reader);

  static Provider<AuthRepository> get provider => _authRepositoryProvider;

  final Reader _reader;

  Account get _account => _reader(Dependency.account);

  Future<User> create({
    required String email,
    required String password,
    required String name,
  }) {
    return exceptionHandler(
      _account.create(
        userId: 'unique()',
        email: email,
        password: password,
        name: name,
      ),
    );
  }

  Future<Session> createSession({
    required String email,
    required String password,
  }) {
    return exceptionHandler(
      _account.createSession(email: email, password: password),
    );
  }

  Future<User> get() {
    return exceptionHandler(
      _account.get(),
    );
  }

  Future<void> deleteSession({required String sessionId}) {
    return exceptionHandler(
      _account.deleteSession(sessionId: sessionId),
    );
  }
}
