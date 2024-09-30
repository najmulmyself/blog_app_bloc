import 'package:blog_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  // it should be interface , because it's function must be implemented

  // it's function must be implemented because it's an abstract **interface** function
  Future<Either<Failure, String>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}
