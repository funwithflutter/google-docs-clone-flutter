import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone/app/providers.dart';
import 'package:google_docs_clone/app/state/state.dart';
import 'package:google_docs_clone/app/utils.dart';
import 'package:google_docs_clone/models/models.dart';
import 'package:google_docs_clone/repositories/repositories.dart';

final _authServiceProvider = StateNotifierProvider<AuthService, AuthState>(
    (ref) => AuthService(ref.read));

class AuthService extends StateNotifier<AuthState> {
  AuthService(this._read)
      : super(const AuthState.unauthenticated(isLoading: true)) {
    refresh();
  }

  static StateNotifierProvider<AuthService, AuthState> get provider =>
      _authServiceProvider;

  final Reader _read;

  Future<void> refresh() async {
    try {
      final user = await _read(Repository.auth).get();
      setUser(user);
    } on RepositoryException catch (_) {
      logger.info('Not authenticated');
      state = const AuthState.unauthenticated();
    }
  }

  void setUser(User user) {
    logger.info('Authentication successful, setting $user');
    state = state.copyWith(user: user, isLoading: false);
  }

  Future<void> signOut() async {
    try {
      await _read(Repository.auth).deleteSession(sessionId: 'current');
      logger.info('Sign out successful');
      state = const AuthState.unauthenticated();
    } on RepositoryException catch (e) {
      state = state.copyWith(error: AppError(message: e.message));
    }
  }
}

class AuthState extends StateBase {
  final User? user;
  final bool isLoading;

  const AuthState({
    this.user,
    this.isLoading = false,
    AppError? error,
  }) : super(error: error);

  const AuthState.unauthenticated({this.isLoading = false})
      : user = null,
        super(error: null);

  @override
  List<Object?> get props => [user, isLoading, error];

  bool get isAuthenticated => user != null;

  AuthState copyWith({
    User? user,
    bool? isLoading,
    AppError? error,
  }) =>
      AuthState(
        user: user ?? this.user,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
      );
}
