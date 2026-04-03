import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mentro_ai_app/WelcomeScreens/WelcomeScreen1.dart';
class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {Timer.periodic(Duration(seconds: 2),(callback){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Welcomescreen1()),
        (Route<dynamic>route)=>false);
  });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/SplashScreenBackground.png"),fit: BoxFit.cover),
        ),
        child: Center(
          child: Image(image: AssetImage("assets/images/logo.png"),height: size.height*0.3,width: double.infinity,),
        ),
      ),
    );
  }
}
