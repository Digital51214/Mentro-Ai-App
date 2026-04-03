import 'package:flutter/material.dart';

class ElevatedButton1 extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ElevatedButton1({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity, // full width
      height: size.height*0.058, // fixed height
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff3A8DD9), // same for all screens
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 3,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}