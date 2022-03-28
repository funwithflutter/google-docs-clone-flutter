import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone/app/constants.dart';
import 'package:google_docs_clone/app/providers.dart';
import 'package:google_docs_clone/repositories/repository_exception.dart';

final _databaseRepositoryProvider = Provider<DatabaseRepository>((ref) {
  return DatabaseRepository(ref.read);
});

class DatabaseRepository with RepositoryExceptionMixin {
  DatabaseRepository(this._read);

  final Reader _read;

  static Provider<DatabaseRepository> get provider =>
      _databaseRepositoryProvider;

  Database get _database => _read(Dependency.database);

  Future<void> createNewPage({
    required String documentId,
    required String owner,
  }) async {
    return exceptionHandler(
        _createPageAndDelta(owner: owner, documentId: documentId));
  }

  Future<void> _createPageAndDelta({
    required String documentId,
    required String owner,
  }) async {
    Future.wait([
      _database.createDocument(
        collectionId: CollectionNames.pages,
        documentId: documentId,
        data: {
          'owner': owner,
          'title': null,
          'content': null,
        },
      ),
      _database.createDocument(
        collectionId: CollectionNames.delta,
        documentId: documentId,
        data: {
          'delta': null,
          'user': null,
          'deviceId': null,
        },
      ),
    ]);
  }
}
