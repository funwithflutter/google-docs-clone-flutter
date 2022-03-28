import 'package:flutter_quill/flutter_quill.dart';
import 'package:google_docs_clone/components/controller_state_base.dart';

import '../../../models/models.dart';

class DocumentState extends ControllerStateBase {
  const DocumentState({
    required this.id,
    this.quillDocument,
    this.quillController,
    AppError? error,
  }) : super(error: error);

  final String id;
  final Document? quillDocument;
  final QuillController? quillController;

  @override
  List<Object?> get props => [id, error];

  @override
  DocumentState copyWith({
    String? id,
    Document? quillDocument,
    QuillController? quillController,
    AppError? error,
  }) {
    return DocumentState(
      id: id ?? this.id,
      quillDocument: quillDocument ?? this.quillDocument,
      quillController: quillController ?? this.quillController,
      error: error ?? this.error,
    );
  }
}
