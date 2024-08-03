import 'package:flutter/material.dart';

class CustomButton2 extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double? height;

  CustomButton2({required this.label, required this.onPressed, this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 108,
        height: height ?? 49,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.92958),
          border: Border.all(
            color: Color(0xFF2F80ED),
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: Offset(0, 2.8169),
              blurRadius: 1.40845,
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Color(0xFF2F80ED),
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
