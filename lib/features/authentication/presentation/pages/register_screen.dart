import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:netigo_front/core/app_colors.dart';
import '../../../shared/presentation/widgets/custom_text_field.dart';
import '../bloc/register/register_cubit.dart';
import '../bloc/register/register_state.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.netigoDarkGrey,
      body: _registerForm(context),
    );
  }

  Widget _registerForm(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 130,
              bottom: 0,
            ),

            child: Image.asset(
              'assets/images/netigo_logo_blue.png',
              width: MediaQuery.of(context).size.width * .9,
            ), //
          ),
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
          const LoginRedirect(),
        ],
      ),
    );
  }

  Widget _firstNameField(context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      // buildWhen: (previous, current) =>
      //     previous.email != current.email &&
      //     FormSubmissionStatus is FormSubmitting,
      builder: (context, state) {
        return Align(
          child: CustomTextField(
            labelText: 'First Name',
            textInputType: TextInputType.name,
            onChanged: (value) {
              context.read<RegisterCubit>().firstNameChanged(value);
            },
          ),
        );
      },
    );
  }

  Widget _lastNameField(context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      // buildWhen: (previous, current) =>
      //     previous.email != current.email &&
      //     FormSubmissionStatus is FormSubmitting,
      builder: (context, state) {
        return Align(
          child: CustomTextField(
            labelText: 'Last Name',
            textInputType: TextInputType.name,
            onChanged: (value) {
              context.read<RegisterCubit>().lastNameChanged(value);
            },
          ),
        );
      },
    );
  }

  Widget _emailField(context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Align(
          child: CustomTextField(
            labelText: 'Email',
            errorText: state.email.invalid ? "Invalid Email" : null,
            textInputType: TextInputType.emailAddress,
            onChanged: (value) {
              context.read<RegisterCubit>().emailChanged(value);
            },
          ),
        );
      },
    );
  }

  Widget _passwordField(context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      // buildWhen: (previous, current) =>
      //     previous.email != current.email &&
      //     FormSubmissionStatus is FormSubmitting,
      builder: (context, state) {
        return Align(
          child: CustomTextField(
            labelText: 'Password',
            obscureText: true,
            errorText: state.password.invalid ? "Invalid Password" : null,
            textInputType: TextInputType.text,
            onChanged: (value) {
              context.read<RegisterCubit>().passwordChanged(value);
            },
          ),
        );
      },
    );
  }

  Widget _registerButton(context) {
    return // Submit Button
        Align(
      child: BlocBuilder<RegisterCubit, RegisterState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.status == FormzStatus.submissionInProgress
              ? const CircularProgressIndicator()
              : InkWell(
                  onTap: () {
                    if (state.status == FormzStatus.valid) {
                      context.read<RegisterCubit>().signupWithCredentials();
                      context.pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Check your inputs: ${state.status}',
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    //Type TextField
                    width: MediaQuery.of(context).size.width * .8,
                    height: 62,

                    decoration: BoxDecoration(
                      color: AppColors.netigoBlue.withOpacity(.75),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }

  // void _showSnackBar(BuildContext context, String message) {
  //   final snackBar = SnackBar(content: Text(message));
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }
}

class LoginRedirect extends StatelessWidget {
  const LoginRedirect({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
      padding: const EdgeInsets.only(
        top: 30,
        bottom: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            "Already have an account?",
            style: TextStyle(
              color: AppColors.netigoLightGrey,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          InkWell(
            onTap: () {
              context.goNamed("login");
            },
            child: const Text(
              "Login",
              style: TextStyle(
                color: AppColors.netigoLightGrey,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w700,
                fontSize: 15,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
