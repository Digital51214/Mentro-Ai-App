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
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.058,
      child: Material(
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(30),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              color: const Color(0xff3A8DD9),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: const Color(0xff2F78BA), // subtle inner border look
                width: 1,
              ),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff4697E0), // slightly lighter top
                  Color(0xff3A8DD9), // original color
                  Color(0xff317FC8), // slightly darker bottom
                ],
              ),
              boxShadow: const [
                // no outside shadow
              ],
            ),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: "poppinbold",
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}