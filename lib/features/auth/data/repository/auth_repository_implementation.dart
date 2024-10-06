import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/error/server_exceptions.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:blog_app/features/auth/data/models/user_models.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImplementation({required this.authRemoteDatasource});

  @override
  Future<Either<Failure, UserModel>> signUpWithEmailAndPassword({
    // TODO : User returned in refrence
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(() async =>
        await authRemoteDatasource.signUpWithEmailAndPassword(
            name: name, email: email, password: password));
  }

  @override
  Future<Either<Failure, UserModel>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => authRemoteDatasource.signInWithEmailAndPassword(
          email: email, password: password),
    );
  }

  Future<Either<Failure, UserModel>> _getUser(
      Future<UserModel> Function() fn) async {
    try {
      final user = await fn();
      return right(user);
    } on AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerExceptions catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }
}
