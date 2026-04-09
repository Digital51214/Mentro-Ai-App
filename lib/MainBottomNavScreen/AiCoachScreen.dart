import 'package:flutter/material.dart';
import 'package:mentro_ai_app/OtherPresentationScreen/SupportCatogriesScreen.dart';
import 'package:mentro_ai_app/Widgets/ElevatedButton1.dart';

class Aicoachscreen extends StatefulWidget {
  const Aicoachscreen({super.key});

  @override
  State<Aicoachscreen> createState() => _AicoachscreenState();
}

class _AicoachscreenState extends State<Aicoachscreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.03,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: size.width * 0.15,
                    height: size.height * 0.07,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Container(
                      width: size.width * 0.13,
                      height: size.width * 0.13,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/images/welcomescreen1image.png',
              width: size.width * 0.8,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Container(
                width: size.width * 0.75,
                height: size.height * 0.4,
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withOpacity(0.08),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(
                  Icons.smart_toy_outlined,
                  size: size.width * 0.2,
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withOpacity(0.4),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
              child: Column(
                children: [
                  Text(
                    "AI Wellness Coach",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: size.width * 0.065,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: "montserrat",
                    ),
                  ),
                  SizedBox(height: size.height * 0.015),
                  Text(
                    "Your personal AI coach for mental wellness, nutrition & skin care — real guidance, anytime you need it.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      height: 1.5,
                      fontSize: size.width * 0.038,
                      fontFamily: "poppin",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ElevatedButton1(text: "Chat With Ai", onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SupportCategoriesScreen()));
              }),
            ),
            SizedBox(height: size.height * 0.04),
          ],
        ),
      ),
    );
  }
}