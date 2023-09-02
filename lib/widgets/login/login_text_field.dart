import 'package:flutter/material.dart';

class LoginTextField extends StatefulWidget {
  const LoginTextField(
      {super.key,
      this.validator,
      this.onSaved,
      this.obscureText = false,
      required this.hintText,
      this.keyboardType = TextInputType.text,
      this.autoCorrect = false,
      this.textCapitalization = TextCapitalization.none});

  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextInputType keyboardType;
  final bool autoCorrect;
  final bool obscureText;
  final String hintText;
  final TextCapitalization textCapitalization;

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  bool valid = false;

  bool showIconValidate(String input) {
    if (widget.validator != null) {
      setState(() {
        valid = widget.validator!(input) == null ? true : false;
      });
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: widget.hintText,
            suffixIcon:
                valid ? const Icon(Icons.check_circle_outline_outlined, color: Colors.green,) : null,
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!)),
            fillColor: Colors.grey[100],
            filled: true),
        style: TextStyle(fontSize: 16),
        keyboardType: widget.keyboardType,
        textCapitalization: widget.textCapitalization,
        autocorrect: widget.autoCorrect,
        obscureText: widget.obscureText,
        onChanged: widget.validator != null ? showIconValidate : null,
        validator: widget.validator,
        onSaved: widget.onSaved,
      ),
    );
  }
}
