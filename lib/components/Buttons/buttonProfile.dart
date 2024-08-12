import 'package:flutter/material.dart';

class ProfileButton extends StatefulWidget {
  final String? text;
  final IconData? icons;

  ProfileButton({
    this.text,
    this.icons,
  });

  @override
  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 1.0,
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.text ?? "",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20.0,
                fontWeight: FontWeight.w700
              ),
            ),
            Icon(
              widget.icons,
              color: Theme.of(context).colorScheme.primary,
            )
          ],
        ),
      ),
    );
  }
}
