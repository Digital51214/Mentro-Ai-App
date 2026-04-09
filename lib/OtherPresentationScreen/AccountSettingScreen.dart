import 'package:flutter/material.dart';
import 'package:mentro_ai_app/AuthonticationScreens/ChangePasswordScreen.dart';
import 'package:mentro_ai_app/MainBottomNavScreen/ProfileScreens/EditProfileScreen.dart';
import 'package:mentro_ai_app/Widgets/Backbutton.dart';
import 'package:mentro_ai_app/Widgets/logoutDiologe.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                  CustomBackButton(),
                  Image.asset(
                    'assets/images/logo.png',
                    height: size.height * 0.07,
                    width: size.width * 0.14,
                    fit: BoxFit.contain,
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.04),

              /// Title
              Text(
                'Account Settings',
                style: TextStyle(
                  fontSize: size.width * 0.07,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontFamily: "semibold",
                ),
              ),

              SizedBox(height: size.height * 0.03),

              _buildSettingTile(
                context: context,
                size: size,
                title: 'Edit Profile',
                icon: Icons.person_outline_rounded,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Editprofilescreen()));
                },
              ),

              SizedBox(height: size.height * 0.01),

              _buildSettingTile(
                context: context,
                size: size,
                title: 'Change Password',
                icon: Icons.lock_outline_rounded,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
                },
              ),

              SizedBox(height: size.height * 0.01),

              _buildSettingTile(
                context: context,
                size: size,
                title: 'Delete Account',
                icon: Icons.delete,
                onTap: () {
                  LogoutDialog.show(context, isDelete: true);
                },
              ),

              SizedBox(height: size.height * 0.04),

              /// Logout Button
              SizedBox(
                width: double.infinity,
                height: size.height * 0.058,
                child: OutlinedButton.icon(
                  onPressed: () {
                    LogoutDialog.show(context, isDelete: false);
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Colors.red.shade400,
                    size: 22,
                  ),
                  label: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: size.width * 0.043,
                      fontWeight: FontWeight.w700,
                      fontFamily: "poppin",
                      color: Colors.red.shade400,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red.shade300, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
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

  Widget _buildSettingTile({
    required BuildContext context,
    required Size size,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      height: size.height * 0.074,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.045),
          child: Row(
            children: [
              Container(
                width: size.width * 0.1,
                height: size.width * 0.1,
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF2196F3),
                  size: size.width * 0.055,
                ),
              ),
              SizedBox(width: size.width * 0.04),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: size.width * 0.037,
                    fontWeight: FontWeight.w800,
                    fontFamily: "poppin",
                    color: Colors.black87,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey.shade400,
                size: size.width * 0.04,
              ),
            ],
          ),
        ),
      ),
    );
  }
}