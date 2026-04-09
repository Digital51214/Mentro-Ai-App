import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentro_ai_app/MainBottomNavScreen/ChatScreens/MainChatScreen.dart';
import 'package:mentro_ai_app/MainBottomNavScreen/AiCoachScreen.dart';
import 'package:mentro_ai_app/MainBottomNavScreen/HomeScreen.dart';
import 'package:mentro_ai_app/MainBottomNavScreen/ProfileScreens/MainProfileScreen.dart';

class BottomNavigationScreen extends StatefulWidget {
  final int initialIndex; // ← ADD THIS

  const BottomNavigationScreen({
    super.key,
    this.initialIndex = 0, // ← default Home tab
  });

  @override
  State<BottomNavigationScreen> createState() =>
      _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  late int selectedIndex;

  final List<Widget> screens = const [
    Homescreen(),
    Aicoachscreen(),
    Mainchatscreen(),
    Mainprofilescreen(),
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex; // ← ADD THIS
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bottomInset = MediaQuery.of(context).padding.bottom;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          screens[selectedIndex],
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.080,
                right: size.width * 0.080,
                bottom: bottomInset + size.height * 0.012,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size.width * 0.09),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                  child: Container(
                    height: size.width * 0.15,
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.005,
                      vertical: size.height * 0.001,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.width * 0.09),
                      color: const Color(0xff3A8DD9).withOpacity(0.1),
                      border: Border.all(
                        color: const Color(0xff3A8DD9).withOpacity(0.3),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _navItem(
                          image: "assets/images/home.png",
                          title: "Home",
                          index: 0,
                          size: size,
                        ),
                        _navItem(
                          image: "assets/images/food.png",
                          title: "Ai Coach",
                          index: 1,
                          size: size,
                        ),
                        _navItem(
                          image: "assets/images/chat.png",
                          title: "Chat",
                          index: 2,
                          size: size,
                        ),
                        _navItem(
                          image: "assets/images/profile.png",
                          title: "Profile",
                          index: 3,
                          size: size,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem({
    required String image,
    required String title,
    required int index,
    required Size size,
  }) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        if (selectedIndex == index) return;
        setState(() {
          selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        height: size.width * 0.14,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? size.width * 0.050 : size.width * 0.035,
          vertical: size.height * 0.012,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.width * 0.08),
          gradient: isSelected
              ? const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff3A8DD9),
              Color(0xff3A8DD9),
            ],
          )
              : null,
          color: isSelected ? null : const Color(0xff3A8DD9).withOpacity(0.25),
          border: Border.all(
            color: isSelected
                ? const Color(0xff3A8DD9)
                : Colors.white.withOpacity(0.12),
            width: 1,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: const Color(0xff3A8DD9).withOpacity(0.28),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              image,
              width: size.width * 0.055,
              height: size.width * 0.055,
              fit: BoxFit.contain,
            ),
            if (isSelected) ...[
              SizedBox(width: size.width * 0.018),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: size.width * 0.032,
                  fontFamily: "poppinbold",
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}