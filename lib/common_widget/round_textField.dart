import "package:fitnessapp/common/color_extension.dart";
import "package:flutter/material.dart";

class RoundTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String hitText;
  final String icon;
  final bool obscureText;
  final Widget? rightIcon;
  final EdgeInsets? margin;
        final String? Function(dynamic value)? validator;

  const RoundTextField(
      {super.key,
      required this.hitText,
      required this.icon,
      this.controller,
      this.margin,
      this.keyboardType,
      this.obscureText = false,

      this.rightIcon, this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
          color: Tcolor.ligthGrey, borderRadius: BorderRadius.circular(15)),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: hitText,
          suffixIcon: rightIcon,
          prefixIcon: Container(
            alignment: Alignment.center,
            width: 20,
            height: 20,
            child: Image.asset(
              icon,
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              color: Tcolor.grey,
            ),
          ),
          hintStyle: TextStyle(color: Tcolor.grey, fontSize: 12),
        ),
      ),
    );
  }
}
