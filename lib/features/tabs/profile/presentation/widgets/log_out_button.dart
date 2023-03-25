import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../authentication/presentation/bloc/auth/auth_bloc.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => CupertinoAlertDialog(
            title: const Text("Log Out?"),
            actions: [
              CupertinoDialogAction(
                child: const Text("Yes"),
                onPressed: () {
                  context.read<AuthBloc>().add(
                        AuthLogoutUser(),
                      );
                },
              ),
              CupertinoDialogAction(
                child: const Text("No"),
                onPressed: () {
                  GoRouter.of(context).pop();
                },
              )
            ],
          ),
        );
      },
      child: const Padding(
        padding: EdgeInsets.only(
          right: 8.0,
          top: 15,
        ),
        child: Text("Log Out"),
      ),
    );
  }
}
