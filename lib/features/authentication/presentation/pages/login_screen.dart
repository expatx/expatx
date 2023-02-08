import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:netigo_front/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:netigo_front/features/authentication/form_submission_status.dart';
import 'package:netigo_front/features/authentication/presentation/bloc/login/login_bloc.dart';
import 'package:netigo_front/features/authentication/presentation/bloc/login/login_event.dart';
import 'package:netigo_front/features/authentication/presentation/bloc/login/login_state.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(
          authRepo: context.read<AuthRepositoryImpl>(),
        ),
        child: _loginForm(context),
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
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
              //Logo
              Container(
                margin: const EdgeInsets.only(
                  top: 140,
                ),

                child: Image.asset('assets/images/netigo_logo_blue.png'), //
              ),

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
              _signInButton(context),
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
                        context.goNamed("register");
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  context.go("/home");
                },
                child: Container(
                  color: Colors.blue,
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  width: MediaQuery.of(context).size.width * .2,
                  height: 60,
                  child: const Center(
                    child: Text("Home Screen"),
                  ),
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
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return TextFormField(
            validator: (value) => state.isValidEmail ? null : "Invalid Email",
            onChanged: (value) => context.read<LoginBloc>().add(
                  EmailChanged(email: value),
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
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return TextFormField(
            obscureText: true,
            validator: (value) =>
                state.isValidPassword ? null : "Invalid Password",
            onChanged: (value) => context.read<LoginBloc>().add(
                  PasswordChanged(password: value),
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

  Widget _signInButton(context) {
    return // Submit Button
        BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(LoginSubmitted());
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
                      "Submit",
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
