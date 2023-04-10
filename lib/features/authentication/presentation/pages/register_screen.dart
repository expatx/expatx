import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:expatx/core/app_colors.dart';
import '../../../shared/presentation/widgets/custom_text_field.dart';
import '../bloc/register/register_cubit.dart';
import '../bloc/register/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //Form Controller and Keys
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //Error Messages
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.expatxDarkGrey,
      body: Form(key: _formKey, child: _registerForm(context)),
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
            controller: _firstNameController,
            onChanged: (value) {
              context.read<RegisterCubit>().firstNameChanged(value);
            },
            validator: (value) => value!.isEmpty ? 'Cannot be blank' : null,
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
            controller: _lastNameController,
            validator: (value) => value!.isEmpty ? 'Cannot be blank' : null,
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
            textInputType: TextInputType.emailAddress,
            onChanged: (value) {
              context.read<RegisterCubit>().emailChanged(value);
            },
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
                return 'Please enter a valid email address';
              } else {
                return null;
              }
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
            textInputType: TextInputType.text,
            onChanged: (value) {
              context.read<RegisterCubit>().passwordChanged(value);
            },
            controller: _passwordController,
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
          return state.status == RegisterFormStatus.loading
              ? const CircularProgressIndicator()
              : InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await context
                          .read<RegisterCubit>()
                          .signupWithCredentials();
                      if (context.mounted) {
                        if (context.read<RegisterCubit>().state.status ==
                            RegisterFormStatus.success) {
                          context.pop();
                        }
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Registration Failed',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
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
                                  'Check your inputs',
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
                    }
                    errorMessage = '';
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
              color: AppColors.expatxLightGrey,
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
                color: AppColors.expatxLightGrey,
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
