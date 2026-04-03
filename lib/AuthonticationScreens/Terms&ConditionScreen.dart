import 'package:flutter/material.dart';
import 'package:mentro_ai_app/Widgets/Backbutton.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  Widget _buildParagraph(String text, double screenWidth) {
    return Text(
      text,
      style: TextStyle(
        fontSize: screenWidth * 0.043,
        fontFamily: "medium",
        height: 1.55,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF2B2B2B),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomBackButton(),
                  SizedBox(width: screenWidth * 0.03),
                  const Expanded(
                    child: Text(
                      'Terms & Conditions',
                      style: TextStyle(
                        fontFamily: "semibold",
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                        height: 1.1,
                      ),
                    ),
                  ),
                  Container(
                    height: screenHeight * 0.07,
                    width: screenWidth * 0.16,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        image: AssetImage("assets/images/logo.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildParagraph(
                        "Welcome to NaijaFit. These Terms & Conditions govern your use of our application and services. By accessing or using NaijaFit, you agree to be bound by these terms. If you do not agree with any part of these terms, you must not use our services.",
                        screenWidth,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      _buildParagraph(
                        "User Accounts\n"
                            "When you create an account with NaijaFit, you agree to provide accurate and complete information. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account. You must notify us immediately of any unauthorized use of your account.\n\n"
                            "Acceptable Use\n"
                            "You agree not to misuse the service or help anyone else do so. This includes, but is not limited to, not posting illegal content, not attempting to probe, scan or test the vulnerability of any system or network, and not engaging in activity that would facilitate survival of malware.",
                        screenWidth,
                      ),
                      SizedBox(height: screenHeight * 0.025),
                      _buildParagraph(
                        "Intellectual Property\n"
                            "All content, features, and functionality of the app (including but not limited to text, images, graphics, logos, and software) are the property of NaijaFit or its licensors and are protected by copyright, trademark, and other intellectual property laws.\n\n"
                            "Limitation of Liability\n"
                            "To the fullest extent permitted by law, NaijaFit and its affiliates will not be liable for any indirect, incidental, special, consequential or punitive damages, or any loss of profits or revenues, whether incurred directly or indirectly.",
                        screenWidth,
                      ),
                      SizedBox(height: screenHeight * 0.025),
                      _buildParagraph(
                        "Changes to These Terms\n"
                            "We may revise these Terms & Conditions at any time. When we do, we will update the date at the top of the terms. By continuing to use the app after those changes become effective, you agree to be bound by the revised terms.\n\n"
                            "Contact Us\n"
                            "If you have questions about these Terms & Conditions, please contact us through the support channels available in the app.",
                        screenWidth,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}