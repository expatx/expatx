import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expatx/features/authentication/domain/usecases/login_user.dart';
import '../../bloc/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUser _loginUser;

  LoginCubit({
    required LoginUser loginUser,
  })  : _loginUser = loginUser,
        super(LoginState.initial());

  void emailChanged(String value) {
   
    emit(
      state.copyWith(
        email: value,
      
      ),
    );
  }

  void passwordChanged(String value) {
    
    emit(
      state.copyWith(
        password: value,
      
      ),
    );
  }

  Future<void> logInWithCredentials() async {
    emit(state.copyWith(status: LoginFormStatus.loading));
    try {
      var result = await _loginUser(
        LoginUserParams(
          email: state.email,
          password: state.password,
        ),
      );
      result.fold(
        (l) => emit(state.copyWith(status: LoginFormStatus.error)),
        (r) => emit(state.copyWith(status: LoginFormStatus.success)),
      );
    } catch (err) {
      emit(state.copyWith(status: LoginFormStatus.error));
    }
  }
}
