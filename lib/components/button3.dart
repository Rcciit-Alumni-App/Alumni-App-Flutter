import 'package:flutter/material.dart';

class CustomButton3 extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  CustomButton3({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 139,
        height: 55,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(19),
          border: Border.all(
            color: Colors.white,
            width: 0.704225,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}
