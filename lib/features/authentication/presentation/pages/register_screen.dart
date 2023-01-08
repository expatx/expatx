import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netigo_front/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:netigo_front/features/authentication/form_submission_status.dart';
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

  Widget _registerForm(context) {
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
            children: [
              const SizedBox(
                height: 10,
              ),
              //Inputs
              _emailField(context),
              const SizedBox(
                height: 30,
              ),
              _passwordField(context),

              const SizedBox(
                height: 30,
              ),
              // _signInButton(context),
              Container(
                width: MediaQuery.of(context).size.width * .8,
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Don't have an account?",
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailField(context) {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xff222121),
        border: Border.all(
          color: Colors.blue,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return TextFormField(
            validator: (value) => state.isValidEmail ? null : "Invalid Email",
            onChanged: (value) => context.read<RegisterBloc>().add(
                  RegisterEmailChanged(email: value),
                ),
            decoration: const InputDecoration(
              // contentPadding: const EdgeInsets.all(10.0),
              border: InputBorder.none,
              // enabledBorder:
              hintText: "Email",
              hintStyle: TextStyle(
                color: Colors.white,
                fontFamily: "Righteous",
                fontSize: 15,
              ),
            ),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.blue,
            ),
          );
        },
      ),
    );
  }

  Widget _passwordField(context) {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xff222121),
        border: Border.all(
          color: Colors.blue,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return TextFormField(
            obscureText: true,
            validator: (value) =>
                state.isValidPassword ? null : "Invalid Password",
            onChanged: (value) => context.read<RegisterBloc>().add(
                  RegisterPasswordChanged(password: value),
                ),
            decoration: const InputDecoration(
              // contentPadding: const EdgeInsets.all(10.0),
              border: InputBorder.none,
              // enabledBorder:
              hintText: "Password",
              hintStyle: TextStyle(
                color: Colors.white,
                fontFamily: "Righteous",
                fontSize: 15,
              ),
            ),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.blue,
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
// // Submit Button
    // Container(

    //   width: MediaQuery.of(context).size.width * .8,
    //   height: 60,

    //   decoration: BoxDecoration(
    //     color: const Color(0xFF003D96).withOpacity(.5),
    //     border: Border.all(
    //       color: Colors.blue,
    //     ),
    //     borderRadius: const BorderRadius.all(
    //       Radius.circular(10),
    //     ),
    //   ),
    //   child: const Center(
    //     child: Text(
    //       "Submit",
    //       style: TextStyle(
    //         color: Colors.white,
    //         fontFamily: "Righteous",
    //         fontSize: 18,
    //       ),
    //     ),
    //   ),
    // ),
    // Container(
    //   width: MediaQuery.of(context).size.width * .8,
    //   padding: const EdgeInsets.only(
    //     top: 30,
    //   ),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //     children: [
    //       const Text(
    //         "Already have an account?",
    //         style: TextStyle(
    //           color: Colors.white,
    //         ),
    //       ),
    //       InkWell(
    //         onTap: () => Navigator.pop(context),
    //         child: const Text(
    //           "Sign In",
    //           style: TextStyle(
    //             color: Colors.blue,
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // )