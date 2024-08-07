import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  int? height;
  int? width;
  final VoidCallback onPressed;

  CustomButton({required this.label, required this.onPressed,this.height,this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width?.toDouble() ?? 108,
        height: height?.toDouble() ?? 49,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(4.92958),
          border: Border.all(
            color: Colors.white,
            width: 0.704225,
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
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
