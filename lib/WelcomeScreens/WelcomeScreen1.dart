import 'package:flutter/material.dart';
import 'package:mentro_ai_app/WelcomeScreens/WelcomeScreen2.dart';
import 'package:mentro_ai_app/Widgets/Background.dart';

class Welcomescreen1 extends StatefulWidget {
  const Welcomescreen1({super.key});

  @override
  State<Welcomescreen1> createState() => _Welcomescreen1State();
}

class _Welcomescreen1State extends State<Welcomescreen1> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.090),
        
                  /// Top image
                  Image.asset(
                    'assets/images/welcomescreen1image.png',
                    width: size.width * 0.78,
                    fit: BoxFit.contain,
                  ),
        
                  SizedBox(height: size.height * 0.045),
        
                  /// Title
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: size.width * 0.077,
                        fontWeight: FontWeight.w700,
                        fontFamily: "montserrat"
                      ),
                      children: const [
                        TextSpan(
                          text: 'Rebuild ',
                          style: TextStyle(
                            color: Color(0xff3B8EDB),
                          ),
                        ),
                        TextSpan(
                          text: 'Your',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
        
                  Text(
                    'Self-Image',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: size.width * 0.068,
                      fontWeight: FontWeight.w700,
                      fontFamily: "montserrat",
                      color: Colors.black,
                    ),
                  ),
        
                  SizedBox(height: size.height * 0.017),
        
                  /// Subtitle
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                    ),
                    child: Text(
                      'Smart support for your mind, meals, and\nskin, all in one place',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: size.width * 0.035,
                        color: Colors.black87,
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                        fontFamily: "poppin"
                      ),
                    ),
                  ),
        
                  SizedBox(height: size.height * 0.028),
        
                  /// Next button
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.06,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Welcomescreen2()),
                              (Route<dynamic>route)=>false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff3F8FDC),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: Text(
                          'Next',
                          style: TextStyle(
                            fontSize: size.width * 0.04,
                            fontWeight: FontWeight.w900,
                            fontFamily: "poppinbold",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
        
                  SizedBox(height: size.height * 0.16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}