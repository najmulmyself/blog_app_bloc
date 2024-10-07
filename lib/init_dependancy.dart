import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:blog_app/features/auth/data/repository/auth_repository_implementation.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependancies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);

  // RegisterFactory is created everytime user requests it
  // serviceLocator.registerLazySingleton is the singleton instance that will be same instance throughout the app
}

void _initAuth() {
  // DataSource
  serviceLocator
    ..registerFactory<AuthRemoteDatasource>(
      /// why we define type here?
      /*
    AuthRepositoryImplementation AuthRepositoryImplementation({required AuthRemoteDatasource authRemoteDatasource})
    */
      // AuthRemoteDatasourceImpl() is a type of AuthRemoteDatasource
      // and AuthRepositoryImplementation needs AuthRemoteDatasource not AuthRemoteDatasourceImpl so if
      // pass only servicelocator() only it will get confused which one to pass

      () => AuthRemoteDatasourceImpl(
        supabaseClient: serviceLocator(),
      ),
    )
    //Repository
    ..registerFactory<AuthRepository>(() => AuthRepositoryImplementation(
          authRemoteDatasource: serviceLocator(),
        ))
    // UseCase
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
        // here's the same problem. UserSignUp needs AuthRepository not AuthRepositoryImplementation.
        // so we need to explictly set the type into the previous serviceLocator
      ),
    )
    ..registerFactory(
      () => UserSignIn(
        serviceLocator(),
        // here's the same problem. UserSignUp needs AuthRepository not AuthRepositoryImplementation.
        // so we need to explictly set the type into the previous serviceLocator
      ),
    )
    ..registerFactory(() => CurrentUser(
          authRepository: serviceLocator(),
        ))

    // Bloc
    ..registerLazySingleton(() => AuthBloc(
          // BLoC should not create new instance everytime in the application.
          // it should just use the existing instance so we define singleton here
          userSignUp: serviceLocator(),
          userSignIn: serviceLocator(),
          currentUser: serviceLocator(),
        ));
}
