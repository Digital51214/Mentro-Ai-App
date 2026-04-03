import 'package:flutter/material.dart';
class Foodloggingscreen extends StatefulWidget {
  const Foodloggingscreen({super.key});

  @override
  State<Foodloggingscreen> createState() => _FoodloggingscreenState();
}

class _FoodloggingscreenState extends State<Foodloggingscreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Text("FoodLoggingScreen"),
      ),
    );
  }
}
