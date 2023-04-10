import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:expatx/core/app_colors.dart';
import '../../../shared/presentation/widgets/custom_text_field.dart';
import '../bloc/login/login_cubit.dart';
import '../bloc/login/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //Error Messages
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.expatxDarkGrey,
      // resizeToAvoidBottomInset: false,
      body: Form(key: _formKey, child: _loginForm(context)),
    );
  }

  Widget _loginForm(BuildContext context) {
    return SingleChildScrollView(
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
              controller: _emailController,
              validator: (value) {
                RegExp regex = RegExp(
                    r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                    r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                    r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                    r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                    r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                    r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                    r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])');
                if (!regex.hasMatch(value!)) {
                  return 'Please enter a valid email';
                } else {
                  return null;
                }
              },
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
            controller: _passwordController,
            onChanged: (value) =>
                context.read<LoginCubit>().passwordChanged(value),
            validator: (value) {
              RegExp regex = RegExp(
                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
              if (!regex.hasMatch(value!)) {
                errorMessage =
                    'Password must contain at least 6 characters, 1 uppercase, 1 lowercase, 1 number and 1 special character';
                return 'Please enter a valid password';
              } else {
                return null;
              }
            },
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
          return state.status == LoginFormStatus.loading
              ? const CircularProgressIndicator()
              : InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await context.read<LoginCubit>().logInWithCredentials();
                      if (context.mounted) {
                        if (context.read<LoginCubit>().state.status ==
                            LoginFormStatus.error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Check your username and password',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: errorMessage == ''
                              ? const Text(
                                  'Please Enter a Valid Email',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              : Text(
                                  errorMessage!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                        ),
                      );
                      errorMessage = '';
                    }
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
