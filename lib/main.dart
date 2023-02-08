import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netigo_front/core/app_router.dart';
import 'package:netigo_front/features/authentication/data/datasources/auth_datasource.dart';
import 'package:netigo_front/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:netigo_front/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:netigo_front/features/authentication/presentation/bloc/login/login_bloc.dart';
import 'package:netigo_front/features/authentication/presentation/bloc/register/register_bloc.dart';
import 'package:url_strategy/url_strategy.dart';

import 'features/authentication/domain/usecases/get_auth_status.dart';
import 'features/authentication/domain/usecases/get_logged_in_user.dart';
import 'features/authentication/domain/usecases/logout_user.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepositoryImpl(
            AuthDatasourceImpl(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              getAuthStatus: GetAuthStatus(
                context.read<AuthRepositoryImpl>(),
              ),
              getLoggedInUser: GetLoggedInUser(
                context.read<AuthRepositoryImpl>(),
              ),
              logoutUser: LogoutUser(
                context.read<AuthRepositoryImpl>(),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => LoginBloc(
              authRepo: AuthRepositoryImpl(
                AuthDatasourceImpl(),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => RegisterBloc(
              authRepo: AuthRepositoryImpl(
                AuthDatasourceImpl(),
              ),
            ),
          ),
        ],
        child: Builder(builder: (context) {
          return MaterialApp.router(
            title: 'Netigo',
            routerConfig: AppRouter(context.read<AuthBloc>()).router,
          );
        }),
      ),
    );
  }
}
