import 'package:google_docs_clone/app/navigation/transition_page.dart';
import 'package:google_docs_clone/components/auth/auth.dart';
import 'package:routemaster/routemaster.dart';

const _login = '/login';
const _register = '/register';
const _document = '/document';
const _newDocument = '/newDocument';

abstract class AppRoutes {
  static String get document => _document;
  static String get newDocument => _newDocument;
  static String get login => _login;
  static String get register => _register;
}

final routesLoggedOut = RouteMap(
  onUnknownRoute: (_) => const Redirect(_login),
  routes: {
    _login: (_) => const TransitionPage(
          child: LoginPage(),
        ),
    _register: (_) => const TransitionPage(
          child: RegisterPage(),
        ),
  },
);

/// TODO: create routesLogggedIn
