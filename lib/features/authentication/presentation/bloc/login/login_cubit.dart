import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:netigo_front/features/authentication/data/datasources/auth_datasource.dart';
import 'package:netigo_front/features/authentication/domain/usecases/login_user.dart';
import '../../../../shared/domain/entities/user_entity.dart';
import '../../bloc/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUser _loginUser;

  LoginCubit({
    required LoginUser loginUser,
  })  : _loginUser = loginUser,
        super(LoginState.initial());

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate(
          [email, state.password],
        ),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate(
          [state.email, password],
        ),
      ),
    );
  }

  Future<void> logInWithCredentials() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _loginUser(
        LoginUserParams(
          email: state.email,
          password: state.password,
        ),
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on LoginWithUsernameAndPasswordFailure catch (err) {
      emit(
        state.copyWith(
          errorText: err.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (err) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
