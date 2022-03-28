import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone/app/app.dart';
import 'package:google_docs_clone/app/navigation/routes.dart';
import 'package:google_docs_clone/components/document/state/document_controller.dart';
import 'package:google_docs_clone/components/document/widgets/widgets.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tuple/tuple.dart';

final _quillControllerProvider =
    Provider.family<QuillController?, String>((ref, id) {
  final test = ref.watch(DocumentController.provider(id));
  return test.quillController;
});

class DocumentPage extends ConsumerWidget {
  const DocumentPage({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  final String documentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          MenuBar(
            newDocumentPressed: () {
              Routemaster.of(context).push(AppRoutes.newDocument);
            },
          ),
          _Toolbar(documentId: documentId),
          Expanded(
            child: _DocumentEditorWidget(
              documentId: documentId,
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentEditorWidget extends ConsumerStatefulWidget {
  const _DocumentEditorWidget({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  final String documentId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __DocumentEditorState();
}

class __DocumentEditorState extends ConsumerState<_DocumentEditorWidget> {
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final quillController =
        ref.watch(_quillControllerProvider(widget.documentId));

    if (quillController == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (event) {
          if (event.data.isControlPressed && event.character == 'b' ||
              event.data.isMetaPressed && event.character == 'b') {
            if (quillController
                .getSelectionStyle()
                .attributes
                .keys
                .contains('bold')) {
              quillController
                  .formatSelection(Attribute.clone(Attribute.bold, null));
            } else {
              quillController.formatSelection(Attribute.bold);
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Card(
            elevation: 7,
            child: Padding(
              padding: const EdgeInsets.all(86.0),
              child: QuillEditor(
                controller: quillController,
                scrollController: _scrollController,
                scrollable: true,
                focusNode: _focusNode,
                autoFocus: false,
                readOnly: false,
                expands: false,
                padding: EdgeInsets.zero,
                customStyles: DefaultStyles(
                  h1: DefaultTextBlockStyle(
                    const TextStyle(
                      fontSize: 36,
                      color: Colors.black,
                      height: 1.15,
                      fontWeight: FontWeight.w600,
                    ),
                    const Tuple2(32, 28),
                    const Tuple2(0, 0),
                    null,
                  ),
                  h2: DefaultTextBlockStyle(
                    const TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    const Tuple2(28, 24),
                    const Tuple2(0, 0),
                    null,
                  ),
                  h3: DefaultTextBlockStyle(
                    TextStyle(
                      fontSize: 24,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                    ),
                    const Tuple2(18, 14),
                    const Tuple2(0, 0),
                    null,
                  ),
                  paragraph: DefaultTextBlockStyle(
                    const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    const Tuple2(2, 0),
                    const Tuple2(0, 0),
                    null,
                  ),
                ),
                embedBuilder: _defaultEmbedBuilderWeb,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _defaultEmbedBuilderWeb(BuildContext context,
      QuillController controller, Embed node, bool readOnly) {
    throw UnimplementedError(
      'Embeddable type "${node.value.type}" is not supported by default '
      'embed builder of QuillEditor. You must pass your own builder function '
      'to embedBuilder property of QuillEditor or QuillField widgets.',
    );
  }
}

class _Toolbar extends ConsumerWidget {
  const _Toolbar({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  final String documentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quillController = ref.watch(_quillControllerProvider(documentId));

    if (quillController == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return QuillToolbar.basic(
      controller: quillController,
      iconTheme: const QuillIconTheme(
        iconSelectedFillColor: AppColors.secondary,
      ),
      multiRowsDisplay: false,
      showAlignmentButtons: true,
    );
  }
}
