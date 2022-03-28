import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone/app/app.dart';

void main() {
  setupLogger();

  runApp(const ProviderScope(child: GoogleDocsApp()));
}
