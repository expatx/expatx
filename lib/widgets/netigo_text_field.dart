import 'package:flutter/material.dart';

class NetigoTextField extends StatelessWidget {
  final String labelText;
  final bool obscure;
  final Function(String)? onChanged;

  const NetigoTextField({
    super.key,
    required this.labelText,
    this.obscure = false,
    this.onChanged,
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
      child: TextFormField(
        obscureText: obscure,
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
        validator: (value) => null,
      ),
    );
  }
}
