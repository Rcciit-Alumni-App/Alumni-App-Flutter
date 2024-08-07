import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyTextField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final double? height;
  final int? maxLines;
  final IconData? icons;

  const MyTextField({
    this.label,
    this.hintText,
    this.height,
    this.maxLines,
    this.icons,
  });

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label ?? "",
          style: TextStyle(
            color: Color(0xFF2F80ED),
          ),
        ),
        Container(
          width: double.infinity,
          height: widget.height ?? 47.0,
          child: TextField(
            maxLines: widget.maxLines,
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: Color(0xFF2F80ED),
              ),
              filled: true,
              fillColor: _isFocused ? Colors.white : Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11.1053),
                borderSide: const BorderSide(
                  color: Color(0xFF2F80ED),
                  width: 2.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11.1053),
                borderSide: const BorderSide(
                  color: Color(0xFF2F80ED),
                  width: 1.11053,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              suffixIcon: widget.icons != null ? Icon(widget.icons) : null,
            ),
          ),
        ),
      ],
    );
  }
}
