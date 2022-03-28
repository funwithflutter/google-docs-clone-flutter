import 'dart:async';

import 'package:appwrite/appwrite.dart';
import 'package:google_docs_clone/app/utils.dart';

class RepositoryException implements Exception {
  const RepositoryException(
      {required this.message, this.exception, this.stackTrace});

  final String message;
  final Exception? exception;
  final StackTrace? stackTrace;

  @override
  String toString() {
    return "RepositoryException: $message)";
  }
}

mixin RepositoryExceptionMixin {
  Future<T> exceptionHandler<T>(
    FutureOr computation, {
    String unkownMessage = 'Repository Exception',
  }) async {
    try {
      return await computation;
    } on AppwriteException catch (e) {
      logger.warning(e.message, e);
      throw RepositoryException(
          message: e.message ?? 'An undefined error occured');
    } on Exception catch (e, st) {
      logger.severe(unkownMessage, e, st);
      throw RepositoryException(
          message: unkownMessage, exception: e, stackTrace: st);
    }
  }
}
