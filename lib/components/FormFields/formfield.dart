import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyTextField extends StatefulWidget {
  final IconData? leadingIcon;
  final bool? isObscure;
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
    this.isObscure,
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
  bool _isValid = true;

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
            color: _isValid ? Color(0xFF2F80ED) : Colors.red[700],
          ),
        ),
        Container(
          width: double.infinity,
          child: Stack(
            children: [
              Container(height: widget.height ?? 47.0),
              TextFormField(
                obscureText: widget.isObscure ?? false,
                validator: (value) {
                  final error = widget.validator?.call(value);
                  setState(() {
                    _isValid = error == null;
                  });
                  return error;
                },
                enabled: widget.enabled,
                style: TextStyle(
                  color: _isValid
                      ? Theme.of(context).colorScheme.primary
                      : Colors.red[700],
                ),
                controller: widget.controller,
                maxLines: widget.isObscure ?? false ? 1 : widget.maxLines,
                onChanged: widget.onChanged,
                onSaved: widget.onSaved,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: _isValid ? Color(0xFF2F80ED) : Colors.red[700],
                  ),
                  filled: true,
                  fillColor: _isFocused
                      ? Colors.white
                      : Colors.grey[200]!.withOpacity(widget.opacity ?? 1.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11.1053),
                    borderSide: BorderSide(
                      color: _isValid ? Color(0xFF2F80ED) : Colors.red[700]!,
                      width: 2.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11.1053),
                    borderSide: BorderSide(
                      color: _isValid ? Color(0xFF2F80ED) : Colors.red[700]!,
                      width: 1.11053,
                    ),
                  ),
                  contentPadding: widget.maxLines == null
                      ? const EdgeInsets.symmetric(horizontal: 10)
                      : const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                  suffixIcon: widget.icons != null
                      ? IconButton(
                          icon: Icon(
                            widget.icons,
                            color: _isValid
                                ? widget.iconColor
                                : Colors.red[700],
                          ),
                          onPressed: widget.button,
                        )
                      : null,
                  prefixIcon: widget.leadingIcon != null
                      ? Icon(
                          widget.leadingIcon,
                          color: _isValid
                              ? widget.iconColor
                              : Colors.red[700],
                        )
                      : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
