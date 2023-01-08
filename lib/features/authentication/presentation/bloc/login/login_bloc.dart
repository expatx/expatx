import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netigo_front/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:netigo_front/features/authentication/form_submission_status.dart';
import 'package:netigo_front/features/authentication/presentation/bloc/login/login_event.dart';
import 'package:netigo_front/features/authentication/presentation/bloc/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepositoryImpl authRepo;
  LoginBloc({required this.authRepo}) : super(LoginState()) {
    on<EmailChanged>(
      ((event, emit) => emit(state.copyWith(email: event.email))),
    );
    on<PasswordChanged>(
      ((event, emit) => emit(state.copyWith(password: event.password))),
    );
    on<LoginSubmitted>(_loginSubmitted);
  }

  _loginSubmitted(event, emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));
    try {
      await authRepo.login(email: state.email!, password: state.password!);
      emit(state.copyWith(formStatus: SubmissionSuccess()));
    } catch (e) {
      emit(state.copyWith(formStatus: SubmissionFailed(e)));
    }
  }
}
