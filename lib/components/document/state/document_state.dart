import 'package:flutter_quill/flutter_quill.dart';
import 'package:google_docs_clone/components/controller_state_base.dart';

import '../../../models/models.dart';

class DocumentState extends ControllerStateBase {
  const DocumentState({
    required this.id,
    this.documentPageData,
    this.quillDocument,
    this.quillController,
    this.isSavedRemotely = false,
    AppError? error,
  }) : super(error: error);

  final String id;
  final DocumentPageData? documentPageData;
  final Document? quillDocument;
  final QuillController? quillController;
  final bool isSavedRemotely;

  @override
  List<Object?> get props => [id, error];

  @override
  DocumentState copyWith({
    String? id,
    DocumentPageData? documentPageData,
    Document? quillDocument,
    QuillController? quillController,
    bool? isSavedRemotely,
    AppError? error,
  }) {
    return DocumentState(
      id: id ?? this.id,
      documentPageData: documentPageData ?? this.documentPageData,
      quillDocument: quillDocument ?? this.quillDocument,
      quillController: quillController ?? this.quillController,
      isSavedRemotely: isSavedRemotely ?? this.isSavedRemotely,
      error: error ?? this.error,
    );
  }
}
