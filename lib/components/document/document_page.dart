import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentPage extends ConsumerWidget {
  const DocumentPage({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  final String documentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(child: Text('doc id: $documentId'));
  }
}
