import 'package:flutter/material.dart';
import 'package:mentro_ai_app/MainBottomNavScreen/ProfileScreens/EditProfileScreen.dart';
import 'package:mentro_ai_app/OtherPresentationScreen/AccountSettingScreen.dart';
import 'package:mentro_ai_app/Widgets/logoutDiologe.dart';

class Mainprofilescreen extends StatefulWidget {
  const Mainprofilescreen({super.key});

  @override
  State<Mainprofilescreen> createState() => _MainprofilescreenState();
}

class _MainprofilescreenState extends State<Mainprofilescreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.06),

                Center(
                  child: Container(
                    width: size.width * 0.335,
                    height: size.width * 0.335,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image(
                        image: AssetImage("assets/images/profile1.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.014),

                Text(
                  'Henry wick',
                  style: TextStyle(
                    fontSize: size.width * 0.048,
                    fontWeight: FontWeight.w900,
                    fontFamily: "montserrat",
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: size.height * 0.001),

                Text(
                  'Exmple@mail.com',
                  style: TextStyle(
                    fontSize: size.width * 0.036,
                    fontFamily: "poppin",
                    color: Colors.grey.shade500,
                  ),
                ),

                SizedBox(height: size.height * 0.02),

                SizedBox(
                  width: size.width * 0.45,
                  height: size.height * 0.06,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Editprofilescreen(),
                        ),
                      );
                    },
                    icon: Icon(Icons.edit, size: 18, color: Colors.white),
                    label: Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: size.width * 0.027,
                        fontWeight: FontWeight.w700,
                        fontFamily: "poppinbold",
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2196F3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.04),

                _buildMenuItem(
                  size: size,
                  icon: Icons.person_outline,
                  iconColor: const Color(0xFF2196F3),
                  title: 'Account Settings',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AccountSettingsScreen()));
                  },
                ),

                SizedBox(height: size.height * 0.01),

                _buildMenuItem(
                  size: size,
                  icon: Icons.tune,
                  iconColor: const Color(0xFF2196F3),
                  title: 'Preferences',
                  onTap: () {},
                ),

                SizedBox(height: size.height * 0.01),

                // ── Notification tile with Switch ──
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _notificationsEnabled = !_notificationsEnabled;
                      });
                    },
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
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
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
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
                                Icons.notifications_outlined,
                                color: const Color(0xFF2196F3),
                                size: size.width * 0.055,
                              ),
                            ),
                            SizedBox(width: size.width * 0.04),
                            Text(
                              'Notifications Settings',
                              style: TextStyle(
                                fontSize: size.width * 0.037,
                                fontWeight: FontWeight.w800,
                                fontFamily: "poppin",
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(width: size.width * 0.06),
                            Switch(
                              value: _notificationsEnabled,
                              onChanged: (val) {
                                setState(() {
                                  _notificationsEnabled = val;
                                });
                              },
                              activeColor: const Color(0xFF2196F3),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.04),

                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.058,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      LogoutDialog.show(context);
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

                SizedBox(height: size.height * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required Size size,
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.045),
            child: Row(
              children: [
                Container(
                  width: size.width * 0.1,
                  height: size.width * 0.1,
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor, size: size.width * 0.055),
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
      ),
    );
  }
}