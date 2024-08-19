import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyTextField extends StatefulWidget {
  final IconData? leadingIcon;
  final void Function()? button;
  final String? label;
  final String? hintText;
  final double? height;
  final int? maxLines;
  final IconData? icons;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final bool? enabled;
  final Color? iconColor;
  final double? opacity;
  final FormFieldValidator<String>? validator;

  const MyTextField({
    this.button,
    this.leadingIcon,
    this.label,
    this.hintText,
    this.height,
    this.maxLines,
    this.icons,
    this.controller,
    this.onChanged,
    this.onSaved,
    this.enabled,
    this.iconColor,
    this.opacity,
    this.validator,
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
          child: Stack(
            children: [
              Container(height: widget.height ?? 47.0),
              TextFormField(
              validator: widget.validator,
              enabled: widget.enabled,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary
              ),
              controller: widget.controller,
              maxLines: widget.maxLines,
              onChanged: widget.onChanged,
              onSaved: widget.onSaved,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: Color(0xFF2F80ED),
                ),
                filled: true,
                fillColor: _isFocused ? Colors.white : Colors.grey[200]!.withOpacity(widget.opacity ?? 1.0),
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
                contentPadding: widget.maxLines == null ? const EdgeInsets.symmetric(horizontal: 10) : const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                suffixIcon: widget.icons != null ? IconButton(icon: Icon(widget.icons, color: widget.iconColor), onPressed: widget.button,) : null,
                prefixIcon: widget.leadingIcon != null ? Icon(widget.leadingIcon, color: widget.iconColor,) : null,
              ),
            ),
            ],
          ),
        ),
      ],
    );
  }
}
