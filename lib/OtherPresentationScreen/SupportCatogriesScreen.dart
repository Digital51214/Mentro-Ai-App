import 'package:flutter/material.dart';
import 'package:mentro_ai_app/OtherPresentationScreen/ChatwithAiscreen.dart';
import 'package:mentro_ai_app/Widgets/Backbutton.dart';

class SupportCategoriesScreen extends StatelessWidget {
  const SupportCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: size.height * 0.025,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Top Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomBackButton(),
                    Image.asset(
                      'assets/images/logo.png',
                      height: size.height * 0.07,
                      width: size.width * 0.14,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
          
                SizedBox(height: size.height * 0.04),
          
                Text(
                  'Choose Support Type',
                  style: TextStyle(
                    fontSize: size.width * 0.06,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontFamily: "montserrat",
                  ),
                ),
          
                SizedBox(height: size.height * 0.012),
          
                Text(
                  'Select the category you want to start chatting with.',
                  style: TextStyle(
                    fontSize: size.width * 0.036,
                    color: Colors.grey.shade600,
                    fontFamily: "poppin",
                    height: 1.4,
                  ),
                ),
          
                SizedBox(height: size.height * 0.035),
          
                _buildSupportTile(
                  context: context,
                  size: size,
                  title: 'Nutrition Support',
                  subtitle:
                  'Track your meals and get smart food\ninsights.',
                ),
          
                SizedBox(height: size.height * 0.01),
          
                _buildSupportTile(
                  context: context,
                  size: size,
                  title: 'Mental Health',
                  subtitle:
                  'Apeak with our AI about day and feeling.',
                ),
          
                SizedBox(height: size.height * 0.01),
          
                _buildSupportTile(
                  context: context,
                  size: size,
                  title: 'Skin care',
                  subtitle:
                  'Get personalized support for your skin\nconcerns.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSupportTile({
    required BuildContext context,
    required Size size,
    required String title,
    required String subtitle,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04,
            vertical: size.height * 0.022,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.grey.shade200,
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade100,
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: size.width * 0.037,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    fontFamily: "poppin",
                  ),
                ),
                SizedBox(height: size.height * 0.008),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: size.width * 0.031,
                    color: Colors.grey.shade600,
                    fontFamily: "poppin",
                    height: 1.5,
                  ),
                ),
                SizedBox(height: size.height * 0.008),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: size.height * 0.045,
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AiNutritionChatScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2196F3),
                        elevation: 0,
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.02,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Start Chat',
                            style: TextStyle(
                              fontSize: size.width * 0.021,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontFamily: "poppinbold",
                            ),
                          ),
                          SizedBox(width: size.width * 0.015),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: size.width * 0.045,
                          ),
                        ],
                      ),
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