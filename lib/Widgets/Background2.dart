import 'package:flutter/material.dart';
class Background2 extends StatelessWidget {
  const Background2({super.key,required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/onboardingimage2.png"),fit: BoxFit.cover),
      ),
      child: child,
    );
  }
}
