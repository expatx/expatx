import 'package:expatx/features/tabs/feed/domain/usecases/create_feed_post.dart';
import 'package:expatx/features/tabs/feed/domain/usecases/like_feed_post.dart';
import 'package:expatx/features/tabs/feed/domain/usecases/unlike_feed_post.dart';
import 'package:expatx/features/tabs/feed/presentation/bloc/feed_post/feed_post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:expatx/core/environment/environment.dart';
import 'package:expatx/core/network/network_info.dart';
import 'package:expatx/features/tabs/feed/data/datasources/feed_datasource.dart';
import 'package:expatx/features/tabs/feed/data/repositories/feed_repository_impl.dart';
import 'package:expatx/features/tabs/feed/domain/usecases/get_feed.dart';
import 'package:expatx/features/tabs/feed/presentation/bloc/feed/feed_bloc.dart';
import 'package:expatx/features/tabs/finances/data/datasource/finance_datasource.dart';
import 'package:expatx/features/tabs/finances/data/repository/finance_repository_impl.dart';
import 'package:expatx/features/tabs/finances/domain/usecase/get_finance_history.dart';
import 'package:expatx/features/tabs/finances/presentation/bloc/finance_bloc.dart';
import 'package:expatx/features/tabs/history/data/datasources/history_datasource.dart';
import 'package:expatx/features/tabs/history/data/repositories/history_repository_impl.dart';
import 'package:expatx/features/tabs/history/domain/usecases/get_job_history.dart';
import 'package:expatx/features/tabs/history/presentation/bloc/history_bloc.dart';
import 'package:expatx/features/tabs/profile/data/datasource/profile_local_datasource.dart';
import 'package:expatx/features/tabs/profile/data/datasource/profile_remote_datasource.dart';
import 'package:expatx/features/tabs/profile/data/repository/profile_repository_impl.dart';
import 'package:expatx/features/tabs/profile/domain/usecase/get_user_profile.dart';
import 'package:expatx/features/tabs/profile/presentation/bloc/user_profile_bloc.dart';

import 'core/app_router.dart';
import 'features/authentication/data/datasources/auth_datasource.dart';
import 'features/authentication/data/repositories/auth_repository_impl.dart';
import 'features/authentication/domain/usecases/get_auth_status.dart';
import 'features/authentication/domain/usecases/get_logged_in_user.dart';
import 'features/authentication/domain/usecases/login_user.dart';
import 'features/authentication/domain/usecases/logout_user.dart';
import 'features/authentication/domain/usecases/register_user.dart';
import 'features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'features/authentication/presentation/bloc/login/login_cubit.dart';
import 'features/authentication/presentation/bloc/register/register_cubit.dart';

void main() {
  // Our default will eventually be DEV, but for now running backend on local.
  const String environment =
      String.fromEnvironment('ENVIRONMENT', defaultValue: Environment.dev);

  Environment().initConfig(environment);

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
            create: (context) => LoginCubit(
              loginUser: LoginUser(
                context.read<AuthRepositoryImpl>(),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => RegisterCubit(
              registerUser: RegisterUser(
                context.read<AuthRepositoryImpl>(),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => FeedBloc(
              getFeed: GetFeed(
                repository: FeedRepositoryImpl(
                  remoteDataSource: FeedDataSourceImpl(),
                ),
              ),
              createPost: CreateFeedPost(
                repository: FeedRepositoryImpl(
                  remoteDataSource: FeedDataSourceImpl(),
                ),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => FeedPostBloc(
              likePost: LikeFeedPost(
                repository: FeedRepositoryImpl(
                  remoteDataSource: FeedDataSourceImpl(),
                ),
              ),
              unlikePost: UnlikeFeedPost(
                repository: FeedRepositoryImpl(
                  remoteDataSource: FeedDataSourceImpl(),
                ),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => HistoryBloc(
              getJobHistory: GetJobHistory(
                repository: HistoryRepositoryImpl(
                  remoteDataSource: HistoryDataSourceImpl(),
                ),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => FinanceBloc(
              getFinanceHistory: GetFinanceHistory(
                repository: FinanceRepositoryImpl(
                  remoteDataSource: FinanceDataSourceImpl(),
                ),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => UserProfileBloc(
              getUserProfile: GetUserProfile(
                repository: ProfileRepositoryImpl(
                  remoteDataSource: ProfileRemoteDatasourceImpl(),
                  localDataSource: ProfileLocalDatasourceImpl(),
                  networkInfo: NetworkInfoImpl(InternetConnectionChecker()),
                ),
              ),
            ),
          ),
        ],
        child: Builder(builder: (bcontext) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Stellar',
            routerConfig: AppRouter(bcontext.read<AuthBloc>()).router,
          );
        }),
      ),
    );
  }
}
