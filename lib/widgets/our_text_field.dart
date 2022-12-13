import 'package:flutter/material.dart';

class OurTextField extends StatelessWidget {
  final String labelText;
  const OurTextField({
    super.key,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
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
      child: TextField(
        decoration: InputDecoration(
          // contentPadding: const EdgeInsets.all(10.0),
          border: InputBorder.none,
          // enabledBorder:
          hintText: labelText,
          hintStyle: const TextStyle(
            color: Colors.white,
            fontFamily: "Righteous",
            fontSize: 15,
          ),
        ),
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.blue,
        ),
      ),
    );
  }
}
