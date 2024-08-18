import 'package:flutter/material.dart';

class CustomButton4 extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  CustomButton4({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 110,
        height: 49,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(15.81),
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
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}
