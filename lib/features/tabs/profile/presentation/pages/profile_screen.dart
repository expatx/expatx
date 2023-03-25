import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netigo_front/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:netigo_front/features/tabs/profile/presentation/bloc/user_profile_bloc.dart';
import 'package:netigo_front/features/tabs/profile/presentation/widgets/log_out_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserProfileBloc>(context).add(GetUserProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About User"),
        actions: const [
          LogOutButton(),
        ],
      ),
      body: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserProfileSuccess) {
            return profileDetails();
          } else if (state is UserProfileFailure) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else {
            return const Center(
              child: Text("No Profile Found!"),
            );
          }
        },
      ),
    );
  }

  Widget profileDetails() {
    var user = context.read<AuthBloc>().state.user;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 2.0),
            blurRadius: 5.0,
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: ClipOval(
              child: Image.asset("assets/images/user_profile.png"),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey,
                border: Border.all()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Name: "),
                const SizedBox(width: 16),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: user.firstName),
                      const TextSpan(text: " "),
                      TextSpan(text: user.lastName)
                    ],
                  ),
                ),
                // Text(profileViewModel.userName),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey,
                border: Border.all()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Email: "),
                const SizedBox(width: 16),
                Text(user.email.value),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
