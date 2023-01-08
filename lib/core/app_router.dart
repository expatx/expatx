import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:netigo_front/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:netigo_front/features/authentication/domain/usecases/get_logged_in_user.dart';
import 'package:netigo_front/features/authentication/presentation/pages/register_screen.dart';

import '../features/authentication/domain/repositories/auth_repository.dart';
import '../features/authentication/presentation/bloc/auth/auth_bloc.dart';
import '../features/authentication/presentation/pages/login_screen.dart';

class AppRouter {
  final AuthBloc authBloc;
  AppRouter(this.authBloc);

  late final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        name: 'login',
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (context) =>
                AuthBloc(getLoggedInUser: GetLoggedInUser(AuthRepository())),
            child: LoginScreen(),
          );
        },
        routes: [
          GoRoute(
            name: 'register',
            path: '/register',
            builder: (BuildContext context, GoRouterState state) {
              return RegisterScreen();
            },
          ),
        ],
      ),
    ],
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
