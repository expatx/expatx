import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:netigo_front/features/authentication/domain/usecases/register_user.dart';
import 'package:netigo_front/features/authentication/presentation/bloc/register/register_state.dart';
import '../../../../shared/domain/entities/user_entity.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUser _registerUser;
  RegisterCubit({required RegisterUser registerUser})
      : _registerUser = registerUser,
        super(RegisterState.initial());

  void firstNameChanged(String value) {
    final firstName = value;
    emit(
      state.copyWith(
        firstName: firstName,
      ),
    );
  }

  void lastNameChanged(String value) {
    final lastName = value;
    emit(
      state.copyWith(
        lastName: lastName,
      ),
    );
  }

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

  Future<void> signupWithCredentials() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _registerUser(
        SignupUserParams(
          firstName: state.firstName,
          lastName: state.lastName,
          email: state.email.value,
          password: state.password,
        ),
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (err) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
