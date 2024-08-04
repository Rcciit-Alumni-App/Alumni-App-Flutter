import 'package:flutter/material.dart';

class Socials extends StatefulWidget {
  final String? label;
  final String? hintText;
  final int? index;

  String? text;

  Socials({
    this.index,
    this.label,
    this.hintText,
  });

  @override
  _SocialsState createState() => _SocialsState();
}

class _SocialsState extends State<Socials> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  final TextEditingController _controller = TextEditingController();


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
          height: 47.0,
          child: TextField(
            controller: _controller,
            onChanged: (value) {
              widget.text = value;
            },
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
            ),
          ),
        ),
      ],
    );
  }
}
