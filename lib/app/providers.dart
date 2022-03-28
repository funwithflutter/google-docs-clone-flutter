import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone/app/constants.dart';
import 'package:google_docs_clone/app/state/state.dart';
import 'package:google_docs_clone/repositories/repositories.dart';

abstract class Dependency {
  static Provider<Client> get client => _clientProvider;
  static Provider<Database> get database => _databaseProvider;
  static Provider<Account> get account => _accountProvider;
  static Provider<Realtime> get realtime => _realtimeProvider;
}

abstract class Repository {
  static Provider<AuthRepository> get auth => AuthRepository.provider;
}

abstract class AppState {
  static StateNotifierProvider<AuthService, AuthState> get auth =>
      AuthService.provider;
}

final _clientProvider = Provider<Client>(
  (ref) => Client()
    ..setProject(appwriteProjectId)
    ..setSelfSigned(status: true)
    ..setEndpoint(appwriteEndpoint),
);

final _databaseProvider =
    Provider<Database>((ref) => Database(ref.read(_clientProvider)));

final _accountProvider = Provider<Account>(
  (ref) => Account(ref.read(_clientProvider)),
);

final _realtimeProvider =
    Provider<Realtime>((ref) => Realtime(ref.read(_clientProvider)));
