import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.labelText,
    this.onChanged,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.validator,
  }) : super(key: key);

  final String labelText;
  final Function(String)? onChanged;
  final TextInputType textInputType;
  final bool obscureText;
  final String? Function(String?)? validator;

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
        onChanged: onChanged,
        keyboardType: textInputType,
        obscureText: obscureText,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.white,
              fontSize: 20,
            ),
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
        validator: validator,
        textAlign: TextAlign.center,
      ),
    );
  }
}
