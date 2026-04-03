import 'package:flutter/material.dart';
class Background extends StatelessWidget {
  const Background({super.key,required this.child});

final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/backgroundimage.png"),fit: BoxFit.cover),
      ),
      child: child,
    );
  }
}
