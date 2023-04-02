import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:expatx/core/app_colors.dart';
import '../../../shared/presentation/widgets/custom_text_field.dart';
import '../bloc/login/login_cubit.dart';
import '../bloc/login/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.expatxDarkGrey,
      // resizeToAvoidBottomInset: false,
      body: _loginForm(context),
    );
  }

  Widget _loginForm(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          _showSnackBar(context, state.errorText ?? "Auth Failure");
        }
      },
      child: SingleChildScrollView(
        reverse: true,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Logo
            Container(
              margin: const EdgeInsets.only(
                top: 190,
                bottom: 0,
              ),

              child: Image.asset(
                'assets/images/netigo_logo_blue.png',
                width: MediaQuery.of(context).size.width * .9,
              ), //
            ),

            //Inputs
            _emailField(context),
            const SizedBox(height: 30),
            _passwordField(context),

            const SizedBox(height: 30),
            _signInButton(context),
            const RegisterRedirect(),
          ],
        ),
      ),
    );
  }

  Widget _emailField(context) {
    return Align(
      child: BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) {
          return previous.email != current.email;
        },
        builder: (context, state) {
          return CustomTextField(
              labelText: "Email",
              onChanged: (value) =>
                  context.read<LoginCubit>().emailChanged(value));
        },
      ),
    );
  }

  Widget _passwordField(context) {
    return Align(
      child: BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) {
          return previous.password != current.password;
        },
        builder: (context, state) {
          return CustomTextField(
            labelText: "Password",
            obscureText: true,
            onChanged: (value) =>
                context.read<LoginCubit>().passwordChanged(value),
          );
        },
      ),
    );
  }

  Widget _signInButton(context) {
    return // Submit Button
        Align(
      child: BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) {
          return previous.status != current.status;
        },
        builder: (context, state) {
          return state.status == FormzStatus.submissionInProgress
              ? const CircularProgressIndicator()
              : InkWell(
                  onTap: () {
                    state.status == FormzStatus.valid
                        ? context.read<LoginCubit>().logInWithCredentials()
                        : ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Check your username and password: ${state.status}',
                              ),
                            ),
                          );
                  },
                  child: Container(
                    //Type TextField
                    width: MediaQuery.of(context).size.width * .8,
                    height: 62,

                    decoration: BoxDecoration(
                      color: AppColors.expatxBlue.withOpacity(.75),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Login",
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

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class RegisterRedirect extends StatelessWidget {
  const RegisterRedirect({
    super.key,
  });

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
            "Don't have an account?",
            style: TextStyle(
              color: AppColors.expatxLightGrey,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          InkWell(
            onTap: () {
              context.goNamed("register");
            },
            child: const Text(
              "Register",
              style: TextStyle(
                color: AppColors.expatxLightGrey,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w700,
                fontSize: 15,
                decoration: TextDecoration.underline,
              ),
            ),
          )
        ],
      ),
    );
  }
}
