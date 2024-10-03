// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:blog_app/features/auth/domain/entity/user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  AuthBloc({
    required UserSignUp userSignUp,
  })  : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthSignUp>(
      (event, emit) async {
        final res = await _userSignUp(
          UserSignUpParams(
            event.name,
            event.email,
            event.password,
          ),
        );
        res.fold((failure) {
          emit(
            AuthFailure(failure.message),
          );
        }, (user) {
          emit(
            AuthSuccess(user),
          );
        });
      },
    );
  }
}
