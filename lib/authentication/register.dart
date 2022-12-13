import 'package:flutter/material.dart';
import 'package:netigo_front/widgets/our_text_field.dart';

class Register extends StatelessWidget {
  const Register({super.key});

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
                top: 120,
              ),
              child: const Text(
                "Register",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontFamily: "Righteous",
                ),
              ),
            ),

            const SizedBox(
              height: 40,
            ),
            //Inputs
            const OurTextField(labelText: "First Name"),
            const SizedBox(
              height: 40,
            ),
            const OurTextField(labelText: "Last Name"),
            const SizedBox(
              height: 40,
            ),
            const OurTextField(labelText: "Email"),
            const SizedBox(
              height: 40,
            ),
            const OurTextField(labelText: "Password"),
            const SizedBox(
              height: 40,
            ),
            // Submit Button
            Container(
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
            Container(
              width: MediaQuery.of(context).size.width * .8,
              padding: const EdgeInsets.only(
                top: 30,
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
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
