import 'package:flutter/material.dart';
import 'package:netigo_front/authentication/register.dart';
import 'package:netigo_front/widgets/our_text_field.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              height: 40,
            ),
            //Inputs
            const OurTextField(labelText: "Username"),
            const SizedBox(
              height: 30,
            ),
            const OurTextField(labelText: "Password"),
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
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Register()),
                    ),
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
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height: 50,
                width: 100,
                color: Colors.blue,
                child: const Center(
                  child: Text("Swipe"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
