import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double? width;
  final double? height;
  final Function onTap;
  const CustomButton({
    super.key,
    required this.text,
    required this.height,
    required this.width,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Color(0xFFB3E5FC), Color(0xFFE1F5FE)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Color(0xFF0288D1), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(75),
              blurRadius: 8,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontFamily: "SFProText",
              color: Color(0xFF01579B),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
