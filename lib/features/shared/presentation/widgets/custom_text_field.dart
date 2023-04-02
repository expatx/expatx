import 'package:flutter/material.dart';
import 'package:expatx/core/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.labelText,
    this.onChanged,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.errorText,
  }) : super(key: key);

  final String labelText;
  final Function(String)? onChanged;
  final TextInputType textInputType;
  final bool obscureText;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.expatxBlue,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextFormField(
        textAlign: TextAlign.center,
        onChanged: onChanged,
        keyboardType: textInputType,
        obscureText: obscureText,
        style: const TextStyle(
          color: Colors.black,
          fontFamily: "Roboto",
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.expatxBlue, width: 1.0),
          ),
          hintText: labelText,
          errorText: errorText,
          hintStyle: const TextStyle(
            color: Colors.black,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
