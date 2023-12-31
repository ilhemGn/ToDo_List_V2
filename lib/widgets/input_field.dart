import 'package:flutter/material.dart';
import 'package:todo_list_v2/constants.dart';

class InputFormField extends StatelessWidget {
  final String? initialValue;
  final String hint;
  final Icon? prefixIcon;
  final bool obscureText;
  final TextInputType textInputType;
  final int? maxLines;
  final Icon? suffixIcon;
  final String? Function(String?) validator;
  final Function(String?) onSave;

  const InputFormField({
    super.key,
    this.initialValue,
    required this.hint,
    this.prefixIcon,
    this.obscureText = false,
    required this.textInputType,
    this.maxLines = 1,
    this.suffixIcon,
    required this.validator,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TextFormField(
        initialValue: initialValue,
        textCapitalization: TextCapitalization.sentences,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.5),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide.none,
          ),
          prefixIcon: prefixIcon,
          filled: true,
          isDense: true,
          fillColor: kFieldColor,
          suffixIcon: suffixIcon,
        ),
        maxLines: maxLines,
        validator: validator,
        onSaved: onSave,
      ),
    ]);
  }
}
