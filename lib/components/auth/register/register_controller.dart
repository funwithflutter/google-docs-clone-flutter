import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone/app/providers.dart';
import 'package:google_docs_clone/components/controller_state_base.dart';
import 'package:google_docs_clone/models/app_error.dart';
import 'package:google_docs_clone/repositories/repositories.dart';

final _registerControllerProvider =
    StateNotifierProvider<RegisterController, ControllerStateBase>(
  (ref) => RegisterController(ref.read),
);

class RegisterController extends StateNotifier<ControllerStateBase> {
  RegisterController(this._read) : super(const ControllerStateBase());

  static StateNotifierProvider<RegisterController, ControllerStateBase>
      get provider => _registerControllerProvider;

  static AlwaysAliveProviderBase<RegisterController> get notifier =>
      provider.notifier;

  final Reader _read;

  Future<void> create({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final user = await _read(Repository.auth)
          .create(email: email, password: password, name: name);

      await _read(Repository.auth)
          .createSession(email: email, password: password);

      /// Sets the global app state user.
      _read(AppState.auth.notifier).setUser(user);
    } on RepositoryException catch (e) {
      state = state.copyWith(error: AppError(message: e.message));
    }
  }
}
