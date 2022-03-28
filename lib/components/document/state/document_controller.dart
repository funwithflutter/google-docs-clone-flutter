import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone/components/document/state/document_state.dart';

final _documentProvider =
    StateNotifierProvider.family<DocumentController, DocumentState, String>(
  (ref, documentId) => DocumentController(
    ref.read,
    documentId: documentId,
  ),
);

class DocumentController extends StateNotifier<DocumentState> {
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
    final quillDoc = Document()..insert(0, '');

    final controller = QuillController(
      document: quillDoc,
      selection: const TextSelection.collapsed(offset: 0),
    );

    state = state.copyWith(
      quillDocument: quillDoc,
      quillController: controller,
    );
  }
}
