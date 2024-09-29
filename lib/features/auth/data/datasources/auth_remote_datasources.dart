import 'package:blog_app/core/error/server_exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDatasource {
  Future<String> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<String> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final SupabaseClient supabaseClient;

  AuthRemoteDatasourceImpl({required this.supabaseClient});

  @override
  Future<String> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {
          "name": name,
        },
      );

      if (response.user == null) {
        throw ServerExceptions(message: "User is Null");
      }

      return response.user!.id;
    } catch (e) {
     throw ServerExceptions(message: e.toString());
    }
  }

  @override
  Future<String> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }
}
