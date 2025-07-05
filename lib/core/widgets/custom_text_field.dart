import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextfield extends StatelessWidget {
  final Function onTapTextField;
  final TextEditingController? controller;
  final String hintext;
  final Widget? prefixIcon;
  final double? width;
  final double? height;
  final int? maxLines;
  final TextAlign? align;
  final Function(String)? onChanged;
  final int? maxLenght;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? label;
  final Color? color;
  final Color? textColor;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final double? fontSize;
  final FontWeight? fontWeight;

  const CustomTextfield({
    required this.onChanged,
    super.key,
    required this.hintext,
    this.controller,
    required this.onTapTextField,
    this.prefixIcon,
    this.width,
    this.height,
    this.maxLines,
    this.align,
    this.maxLenght,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.label,
    this.color,
    this.textColor,
    this.focusNode,
    this.suffixIcon,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      width: width ?? 320,
      child: TextFormField(
        focusNode: focusNode,
        validator: validator,
        maxLength: maxLenght,
        onTap: () {
          onTapTextField();
        },
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        maxLines: maxLines,
        controller: controller,
        textAlign: align ?? TextAlign.start,
        style: TextStyle(
          height: 2,
          color: textColor ?? Colors.white,
          fontFamily: "SFProDisplay",
          fontSize: 18,
          fontWeight: fontWeight,
        ),
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          label: label,
          prefixIcon: prefixIcon,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: const Color.fromARGB(255, 255, 0, 0)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: const Color.fromARGB(255, 255, 0, 0), width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          labelStyle: TextStyle(
            fontFamily: "SFProDisplay",
            color: Colors.grey[500],
            fontSize: 18,
          ),
          filled: true,
          fillColor: color ?? Colors.black,
          hintStyle: TextStyle(
            fontFamily: "SFProDisplay",
            color: Colors.grey[500],
            fontSize: 18,
          ),
          hintText: hintext,
        ),
      ),
    );
  }
}
