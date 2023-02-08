import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String name;
  final String age;
  const DetailsScreen({
    super.key,
    required this.name,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(age),
      ),
    );
  }
}
