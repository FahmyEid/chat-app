import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomContainer extends StatelessWidget {
   CustomContainer({this.onTap,
    super.key, required this.text,
  });
final String text;
VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(18)),
        child:  Center(
          child: Text(text,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}