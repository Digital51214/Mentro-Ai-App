import 'package:flutter/material.dart';
class Mainprofilescreen extends StatefulWidget {
  const Mainprofilescreen({super.key});

  @override
  State<Mainprofilescreen> createState() => _MainprofilescreenState();
}

class _MainprofilescreenState extends State<Mainprofilescreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Text("MainProfile"),
      ),
    );
  }
}
