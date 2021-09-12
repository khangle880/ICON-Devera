import 'package:flutter/material.dart';

class ObscureTextField extends StatefulWidget {
  const ObscureTextField(
      {Key? key,
      this.controller,
      this.hintText,
      this.validator,
      this.onChange,
      this.labelText,
      this.autofocus})
      : super(key: key);

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final Function(String value)? onChange;
  final String? labelText;
  final bool? autofocus;

  @override
  _ObscureTextFieldState createState() => _ObscureTextFieldState();
}

class _ObscureTextFieldState extends State<ObscureTextField> {
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      onChanged: widget.onChange,
      autofocus: widget.autofocus ?? false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: Theme.of(context).textTheme.bodyText1,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.labelText,
        suffixIcon: IconButton(
          icon: Icon(_obscureText
              ? Icons.remove_red_eye_outlined
              : Icons.remove_red_eye_rounded),
          onPressed: _toggle,
        ),
        hintText: widget.hintText,
        alignLabelWithHint: true,
      ),
    );
  }
}
