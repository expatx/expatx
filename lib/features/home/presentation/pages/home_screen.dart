import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text("Home Screen"),
            InkWell(
              onTap: () {
                context.goNamed(
                  "details",
                  params: {"name": "Jake"},
                  queryParams: {"age": "24"},
                );
              },
              child: Container(
                color: Colors.blue,
                margin: const EdgeInsets.only(
                  top: 20,
                ),
                width: MediaQuery.of(context).size.width * .2,
                height: 60,
                child: const Center(
                  child: Text("Details"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
