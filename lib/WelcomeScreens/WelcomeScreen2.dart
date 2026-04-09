import 'package:flutter/material.dart';
import 'package:mentro_ai_app/AuthonticationScreens/LoginScreen.dart';
import 'package:mentro_ai_app/Widgets/Background.dart';

class Welcomescreen2 extends StatefulWidget {
  const Welcomescreen2({super.key});

  @override
  State<Welcomescreen2> createState() => _Welcomescreen2State();
}

class _Welcomescreen2State extends State<Welcomescreen2> {
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
                    'assets/images/welcomescreen2image.png',
                    width: size.width * 0.79,
                    fit: BoxFit.contain,
                  ),

                  SizedBox(height: size.height * 0.048),

                  /// Title
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: size.width * 0.077,
                        fontWeight: FontWeight.w900,
                        fontFamily: "montserrat"
                      ),
                      children: const [
                        TextSpan(
                          text: 'Everything ',
                          style: TextStyle(
                            color: Color(0xff3B8EDB),
                          ),
                        ),
                        TextSpan(
                          text: 'You Need',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Text(
                    'in one Secure App',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: size.width * 0.066,
                      fontFamily: "montserrat",
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: size.height * 0.02),

                  /// Subtitle
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.12,
                    ),
                    child: Text(
                      'Smart support for your mind, meals, and\nskin, all in one place',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: size.width * 0.03,
                        color: Colors.black87,
                        fontFamily: "poppin",
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  SizedBox(height: size.height * 0.03),

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
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SignInScreen()),
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