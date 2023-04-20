import 'package:flutter/material.dart';
import 'package:expatx/core/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.labelText,
    this.onChanged,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.controller,
  }) : super(key: key);

  final String labelText;
  final Function(String)? onChanged;
  final TextInputType textInputType;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.expatxPurple,
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
        controller: controller,
        validator: validator,
        style: const TextStyle(
          color: Colors.black,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(
              // top: 20,
              // bottom: 20,
              ),
          // helperText: 'hello',
          // isCollapsed: false,
          // errorBorder: const OutlineInputBorder(
          //   borderRadius: BorderRadius.all(
          //     Radius.circular(10),
          //   ),
          //   borderSide: BorderSide(
          //     color: Colors.yellow,
          //     width: 2.0,
          //   ),
          // ),
          // focusedErrorBorder: const OutlineInputBorder(
          //   borderRadius: BorderRadius.all(
          //     Radius.circular(10),
          //   ),
          //   borderSide: BorderSide(
          //     color: AppColors.expatxPurple,
          //     width: 2.0,
          //   ),
          // ),
          // filled: true,
          // fillColor: AppColors.expatxFadedColor,
          border: InputBorder.none,

          // const OutlineInputBorder(
          //   borderRadius: BorderRadius.all(
          //     Radius.circular(10),
          //   ),
          //   borderSide: BorderSide(
          //     color: AppColors.expatxPurple,
          //     width: 2.0,
          //   ),
          // ),
          // focusedBorder: const OutlineInputBorder(
          //   borderRadius: BorderRadius.all(
          //     Radius.circular(10),
          //   ),
          //   borderSide: BorderSide(
          //     color: AppColors.expatxPurple,
          //     width: 2.0,
          //   ),
          // ),
          hintText: labelText,
          hintStyle: const TextStyle(
            color: AppColors.expatxBlack,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
          // errorStyle: const TextStyle(fontSize: 0.01),
        ),
      ),
    );
  }
}
