import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expatx/features/authentication/domain/usecases/register_user.dart';
import 'package:expatx/features/authentication/presentation/bloc/register/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUser _registerUser;
  RegisterCubit({required RegisterUser registerUser})
      : _registerUser = registerUser,
        super(RegisterState.initial());

  void firstNameChanged(String value) {
    emit(
      state.copyWith(
        firstName: value,
      ),
    );
  }

  void lastNameChanged(String value) {

    emit(
      state.copyWith(
        lastName: value,
      ),
    );
  }

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

  Future<void> signupWithCredentials() async {
    emit(state.copyWith(status: RegisterFormStatus.loading));
    try {
      var response = await _registerUser(
        SignupUserParams(
          firstName: state.firstName,
          lastName: state.lastName,
          email: state.email,
          password: state.password,
        ),
      );
      response.fold((l){
        emit(state.copyWith(status: RegisterFormStatus.error));
      }, (r){
        emit(state.copyWith(status: RegisterFormStatus.success));
      });
    } catch (err) {
      emit(state.copyWith(status: RegisterFormStatus.error));
    }
  }
}
