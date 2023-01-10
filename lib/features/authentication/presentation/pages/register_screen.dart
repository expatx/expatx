import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:netigo_front/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:netigo_front/features/authentication/form_submission_status.dart';
import 'package:netigo_front/features/shared/presentation/widgets/custom_text_field.dart';
import '../bloc/register/register_bloc.dart';
import '../bloc/register/register_event.dart';
import '../bloc/register/register_state.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => RegisterBloc(
          authRepo: context.read<AuthRepositoryImpl>(),
        ),
        child: _registerForm(context),
      ),
    );
  }

  Widget _registerForm(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        }
      },
      child: Form(
        key: _formKey,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/home_background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _firstNameField(context),
              const SizedBox(
                height: 20,
              ),
              _lastNameField(context),
              const SizedBox(
                height: 20,
              ),
              _emailField(context),
              const SizedBox(
                height: 20,
              ),
              _passwordField(context),
              const SizedBox(
                height: 40,
              ),
              _registerButton(context),
              const HaveAccountRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _firstNameField(context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      // buildWhen: (previous, current) =>
      //     previous.email != current.email &&
      //     FormSubmissionStatus is FormSubmitting,
      builder: (context, state) {
        return CustomTextField(
          labelText: 'First Name',
          validator: (value) {
            if (state.isValidFirstName) {
              return null;
            } else {
              return "Invalid First Name";
            }
          },
          textInputType: TextInputType.name,
          onChanged: (value) {
            context
                .read<RegisterBloc>()
                .add(RegisterFirstNameChanged(firstName: value));
          },
        );
      },
    );
  }

  Widget _lastNameField(context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      // buildWhen: (previous, current) =>
      //     previous.email != current.email &&
      //     FormSubmissionStatus is FormSubmitting,
      builder: (context, state) {
        return CustomTextField(
          labelText: 'Last Name',
          validator: (value) {
            if (state.isValidFirstName) {
              return null;
            } else {
              return "Invalid Last Name";
            }
          },
          textInputType: TextInputType.name,
          onChanged: (value) {
            context
                .read<RegisterBloc>()
                .add(RegisterLastNameChanged(lastName: value));
          },
        );
      },
    );
  }

  Widget _emailField(context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      // buildWhen: (previous, current) =>
      //     previous.email != current.email &&
      //     FormSubmissionStatus is FormSubmitting,
      builder: (context, state) {
        return CustomTextField(
          labelText: 'Email',
          validator: (value) {
            if (state.isValidEmail) {
              return null;
            } else {
              return "Invalid Email";
            }
          },
          textInputType: TextInputType.emailAddress,
          onChanged: (value) {
            context
                .read<RegisterBloc>()
                .add(RegisterEmailChanged(email: value));
          },
        );
      },
    );
  }

  Widget _passwordField(context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      // buildWhen: (previous, current) =>
      //     previous.email != current.email &&
      //     FormSubmissionStatus is FormSubmitting,
      builder: (context, state) {
        return CustomTextField(
          labelText: 'Password',
          validator: (value) {
            if (state.isValidPassword) {
              return null;
            } else {
              return "Invalid Password";
            }
          },
          textInputType: TextInputType.text,
          onChanged: (value) {
            context
                .read<RegisterBloc>()
                .add(RegisterEmailChanged(email: value));
          },
        );
      },
    );
  }

  Widget _registerButton(context) {
    return // Submit Button
        BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<RegisterBloc>().add(RegisterSubmitted());
                  }
                },
                child: Container(
                  //Type TextField
                  width: MediaQuery.of(context).size.width * .8,
                  height: 60,

                  decoration: BoxDecoration(
                    color: const Color(0xFF003D96).withOpacity(.5),
                    border: Border.all(
                      color: Colors.blue,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Righteous",
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class HaveAccountRow extends StatelessWidget {
  const HaveAccountRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
      padding: const EdgeInsets.only(
        top: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            "Already have an account?",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          InkWell(
            onTap: () {
              context.goNamed("login");
            },
            child: const Text(
              "Register Screen",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          )
        ],
      ),
    );
  }
}
