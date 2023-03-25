import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/authentication/data/datasources/auth_datasource.dart';
import '../features/authentication/presentation/bloc/auth/auth_bloc.dart';
import '../features/authentication/presentation/pages/login_screen.dart';
import '../features/authentication/presentation/pages/register_screen.dart';
import '../features/shared/presentation/pages/feed_screen.dart';

class AppRouter {
  final AuthBloc authBloc;
  AppRouter(this.authBloc);

  late final GoRouter router = GoRouter(
    initialLocation: "/",
    routes: <GoRoute>[
      GoRoute(
        name: 'feed',
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const FeedScreen();
        },
      ),
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
        routes: [
          GoRoute(
            name: 'register',
            path: 'register',
            builder: (BuildContext context, GoRouterState state) {
              return const RegisterScreen();
            },
          ),
        ],
      ),
    ],
    redirect: (
      BuildContext context,
      GoRouterState state,
    ) {
      // ignore: deprecated_member_use
      final loginLocation = state.namedLocation('login');
      // ignore: deprecated_member_use
      final signupLocation = state.namedLocation('register');

      final bool isLoggedIn = authBloc.state.status == AuthStatus.authenticated;
      // ignore: avoid_print
      print(authBloc.state.status);

      final isLoggingIn = state.subloc == loginLocation;
      final isSigningUp = state.subloc == signupLocation;

      if (!isLoggedIn && !isLoggingIn && !isSigningUp) {
        return '/login';
      }
      if (isLoggedIn && isLoggingIn) {
        return '/';
      }
      if (isLoggedIn && isSigningUp) {
        return '/';
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  /// Creates a [GoRouterRefreshStream].
  ///
  /// Every time the [stream] receives an event the [GoRouter] will refresh its
  /// current route.
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
