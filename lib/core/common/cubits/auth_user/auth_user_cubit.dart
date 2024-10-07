import 'package:bloc/bloc.dart';
import 'package:blog_app/core/common/entity/user.dart';
import 'package:meta/meta.dart';

part 'auth_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void updateUser(User? user) {
    if (user == null) {
      emit(AppUserInitial());
    } else {
      emit(AppUserLoggedIn(user));
    }
  }
}
