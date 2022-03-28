import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone/app/providers.dart';
import 'package:google_docs_clone/app/utils.dart';
import 'package:google_docs_clone/components/document/state/document_state.dart';
import 'package:google_docs_clone/models/models.dart';
import 'package:google_docs_clone/repositories/repositories.dart';

final _documentProvider =
    StateNotifierProvider.family<DocumentController, DocumentState, String>(
  (ref, documentId) => DocumentController(
    ref.read,
    documentId: documentId,
  ),
);

class DocumentController extends StateNotifier<DocumentState> {
  /// Debounce [Timer] for automatic saving.
  Timer? _debounce;

  DocumentController(this._read, {required String documentId})
      : super(
          DocumentState(id: documentId),
        ) {
    _setupDocument();
  }

  static StateNotifierProviderFamily<DocumentController, DocumentState, String>
      get provider => _documentProvider;

  static AlwaysAliveProviderBase<DocumentController> notifier(
          String documentId) =>
      provider(documentId).notifier;

  final Reader _read;

  Future<void> _setupDocument() async {
    try {
      final docPageData = await _read(Repository.database).getPage(
        documentId: state.id,
      );

      late final Document quillDoc;
      if (docPageData.content.isEmpty) {
        quillDoc = Document()..insert(0, '');
      } else {
        quillDoc = Document.fromDelta(docPageData.content);
      }

      final controller = QuillController(
        document: quillDoc,
        selection: const TextSelection.collapsed(offset: 0),
      );

      state = state.copyWith(
        documentPageData: docPageData,
        quillDocument: quillDoc,
        quillController: controller,
        isSavedRemotely: true,
      );

      state.quillController?.addListener(_quillControllerUpdate);
    } on RepositoryException catch (e) {
      state = state.copyWith(error: AppError(message: e.message));
    }
  }

  void _quillControllerUpdate() {
    state = state.copyWith(isSavedRemotely: false);
    _debounceSave();
  }

  void _debounceSave({Duration duration = const Duration(seconds: 2)}) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(duration, () {
      saveDocumentImmediately();
    });
  }

  void setTitle(String title) {
    state = state.copyWith(
      documentPageData: state.documentPageData?.copyWith(
        title: title,
      ),
      isSavedRemotely: false,
    );
    _debounceSave(duration: const Duration(milliseconds: 500));
  }

  Future<void> saveDocumentImmediately() async {
    logger.info('Saving document: ${state.id}');
    if (state.documentPageData == null || state.quillDocument == null) {
      logger.severe('Cannot save document, doc state is empty');
      state = state.copyWith(
        error: AppError(message: 'Cannot save document, state is empty'),
      );
    }
    state = state.copyWith(
      documentPageData: state.documentPageData!
          .copyWith(content: state.quillDocument!.toDelta()),
    );
    try {
      await _read(Repository.database).updatePage(
        documentId: state.id,
        documentPage: state.documentPageData!,
      );
      state = state.copyWith(isSavedRemotely: true);
    } on RepositoryException catch (e) {
      state = state.copyWith(
        error: AppError(message: e.message),
        isSavedRemotely: false,
      );
    }
  }

  @override
  void dispose() {
    state.quillController?.removeListener(_quillControllerUpdate);
    super.dispose();
  }
}
