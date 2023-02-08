import 'dart:async';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:netigo_front/features/authentication/presentation/pages/register_screen.dart';
import 'package:netigo_front/features/home/presentation/pages/details.dart';
import 'package:netigo_front/features/home/presentation/pages/home_screen.dart';

import '../features/authentication/presentation/bloc/auth/auth_bloc.dart';
import '../features/authentication/presentation/pages/login_screen.dart';

class AppRouter {
  final AuthBloc authBloc;
  AppRouter(this.authBloc);

  late final GoRouter router = GoRouter(
    initialLocation: "/",
    routes: <GoRoute>[
      GoRoute(
        name: 'login',
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return LoginScreen();
        },
      ),
      GoRoute(
        name: 'register',
        path: '/register',
        builder: (BuildContext context, GoRouterState state) {
          return RegisterScreen();
        },
      ),
      GoRoute(
        name: 'home',
        path: '/home',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
        routes: [
          GoRoute(
            name: "details",
            path: "details/:name",
            builder: (context, state) {
              return DetailsScreen(
                name: state.params["name"]!,
                age: state.queryParams["age"]!,
              );
            },
          ),
        ],
      ),
    ],
    // errorBuilder: (context, state) => const ErrorScreen(),
    // redirect: (
    //   BuildContext context,
    //   GoRouterState state,
    // ) {
    //   final loginLocation = state.namedLocation('login');
    //   final signupLocation = state.namedLocation('signup');

    //   final bool isLoggedIn = authBloc.state.status == AuthStatus.authenticated;

    //   final isLoggingIn = state.subloc == loginLocation;
    //   final isSigningUp = state.subloc == signupLocation;

    //   if (!isLoggedIn && !isLoggingIn && !isSigningUp) {
    //     return '/login';
    //   }
    //   if (isLoggedIn && isLoggingIn) {
    //     return '/';
    //   }
    //   if (isLoggedIn && isSigningUp) {
    //     return '/';
    //   }
    //   return null;
    // },
    // refreshListenable: GoRouterRefreshStream(authBloc.stream),
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
