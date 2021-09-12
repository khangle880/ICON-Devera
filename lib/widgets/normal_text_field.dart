import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NormalTextField extends StatelessWidget {
  const NormalTextField(
      {Key? key,
      this.controller,
      this.hintText,
      this.validator,
      this.keyboardType,
      this.onChange,
      this.labelText,
      this.autofocus,
      this.textCapitalization,
      this.focusNode,
      this.initialValue})
      : super(key: key);

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final TextInputType? keyboardType;
  final Function(String value)? onChange;
  final String? labelText;
  final bool? autofocus;
  final TextCapitalization? textCapitalization;
  final FocusNode? focusNode;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      focusNode: focusNode,
      onChanged: onChange,
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      autofocus: autofocus ?? false,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        alignLabelWithHint: true,
      ),
    );
  }
}
