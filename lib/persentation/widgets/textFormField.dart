import 'package:app/data/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../data/constants/assets.dart';
import '../../theme/colors.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    required this.text,
    required this.controller,
    this.textColor,
    this.keyboardType,
    this.isPassword,
    this.color,
    this.isFilld,
    this.enabled,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines,
    this.borderRadius,
    this.validator,
    this.fontFamily,
    this.borderColor,
    this.onChanged,
    this.scrollPadding,
    this.borderSide,
    this.contentPadding,
    this.fontSize,
    this.hintColor,
  });

  String text;
  Color? textColor;
  Color? color;
  Color? hintColor;
  TextInputType? keyboardType;
  bool? isPassword;
  TextEditingController controller;
  bool? isFilld;
  bool? enabled;
  Widget? suffixIcon;
  Widget? prefixIcon;
  int? maxLines;
  BorderRadius? borderRadius;
  String? Function(String?)? validator;
  Function(String)? onChanged;
  String? fontFamily;
  Color? borderColor;
  BorderSide? borderSide;
  EdgeInsets? scrollPadding;
  EdgeInsets? contentPadding;
  double? fontSize;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      scrollPadding: scrollPadding ?? EdgeInsets.zero,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      enabled: enabled,
      style: TextStyle(
        color: isFilld != null && isFilld == true ? textColor ?? Colors.black : Colors.white,
        fontFamily: fontFamily,
        fontSize: fontSize,
      ),
      maxLines: maxLines ?? 1,
      minLines: maxLines ?? 1,
      obscureText: isPassword ?? false,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        errorStyle: const TextStyle(color: MyColors.redColor),
        filled: isFilld,
        fillColor: color ?? Colors.white,
        hintText: text,
        hintStyle: TextStyle(
          // fontFamily: Fonts.arabic,
          color: isFilld != null && isFilld == true ? hintColor ?? Colors.grey : Colors.white,
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        contentPadding: contentPadding ?? const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(20),
          borderSide: borderSide ?? BorderSide(color: borderColor ?? Colors.grey, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(20),
          borderSide: borderSide ?? BorderSide(color: borderColor ?? Colors.grey, width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(20),
          borderSide: borderSide ?? BorderSide(color: borderColor ?? Colors.grey, width: 0.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(20),
          borderSide: const BorderSide(color: MyColors.redColor, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(20),
          borderSide: borderSide ?? const BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      cursorColor: isFilld == true ? MyColors.mainColor : Colors.white,
    );
  }
}
