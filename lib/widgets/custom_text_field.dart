import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextformField extends StatelessWidget {
  CustomTextformField(
      {super.key,
      required this.label,
      required this.prefixIcon,
      this.onChanged,
      this.obscureText=false});
  final String label;
  final IconData prefixIcon;
  Function(String)? onChanged;
  bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText:obscureText! ,
      validator: (data) {
        if (data!.isEmpty) {
          return "field is required";
        }
        return null;
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.white,
        ),
      ),
    );
  }
}
