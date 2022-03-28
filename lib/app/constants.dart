const appwriteEndpoint = 'http://localhost/v1';
const appwriteProjectId = '6241851fa5fe35076532'; // TODO: modify this

abstract class CollectionNames {
  static String get delta => 'delta';
  static String get deltaDocumentsPath => 'collections.$delta.documents';
  static String get pages => 'pages';
  static String get pagesDocumentsPath => 'collections.$pages.documents';
}
