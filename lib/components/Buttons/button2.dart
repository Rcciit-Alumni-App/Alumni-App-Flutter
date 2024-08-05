import 'package:flutter/material.dart';

class CustomButton2 extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double? height;
  final double? width;

  CustomButton2({required this.label, required this.onPressed, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? 108,
        height: height ?? 49,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.81),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 1.11053,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
