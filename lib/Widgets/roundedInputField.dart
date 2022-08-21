import 'package:flutter/material.dart';

class RoundedInputField extends StatefulWidget {
  final hintText;
  final IconData;
  final suffixIcon;
  bool obscureText;
  final ValueChanged<String> onChanged;
  RoundedInputField({
    Key? key,
    required this.hintText,
    required this.IconData,
    required this.onChanged,
    this.suffixIcon,
    this.obscureText = false,
  }) : super(key: key);

  @override
  State<RoundedInputField> createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedInputField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: true,
      obscureText: widget.obscureText,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        icon: widget.IconData,
        hintText: widget.hintText,
        border: InputBorder.none,
        suffixIcon: widget.suffixIcon != null
            ? SizedBox(
                height: 5,
                child: GestureDetector(
                  onTapDown: (details) {
                    setState(() {
                      widget.obscureText = false;
                    });
                  },
                  onTapUp: (details) {
                    setState(() {
                      widget.obscureText = true;
                    });
                  },
                  child: widget.suffixIcon,
                ),
              )
            : null,
      ),
    );
  }
}
