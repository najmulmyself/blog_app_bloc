// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:meta/meta.dart';

import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  AuthBloc({
    required UserSignUp userSignUp,
  })  : _userSignUp = userSignUp,
        super(AuthInitial()) {
    print("not clling");
    on<AuthSignUp>(
      (event, emit) async {
        print("called");
        final res = await _userSignUp(
          UserSignUpParams(
            event.name,
            event.email,
            event.password,
          ),
        );

        print(" ${res.getLeft()}");

        res.fold(
          (failure) => emit(
            AuthFailure(failure.message),
          ),
          (uid) => emit(
            AuthSuccess(uid),
          ),
        );
      },
    );
  }
}
