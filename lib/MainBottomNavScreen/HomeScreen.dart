import 'package:flutter/material.dart';
import 'package:mentro_ai_app/OtherPresentationScreen/NotificationScreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final PageController _pageController = PageController(
    viewportFraction: 0.86,
    initialPage: 1,
  );

  double _currentPage = 1;

  final List<Map<String, String>> _featureCards = [
    {
      'title': 'Nutrition Support',
      'subtitle': 'Track your meals and get smart food insights',
      'buttonText': 'Log Food',
      'image': 'assets/images/homecontainerimage.png',
    },
    {
      'title': 'Mental Health',
      'subtitle': 'Speak with our AI about your day and feelings',
      'buttonText': 'Start Chat',
      'image': 'assets/images/homecontainerimage.png',
    },
    {
      'title': 'Skin Care',
      'subtitle': 'Get personalized support for your skin concerns',
      'buttonText': 'View Care',
      'image': 'assets/images/homecontainerimage.png',
    },
    {
      'title': 'Skin Care',
      'subtitle': 'Get personalized support for your skin concerns',
      'buttonText': 'View Care',
      'image': 'assets/images/homecontainerimage.png',
    },
    {
      'title': 'Skin Care',
      'subtitle': 'Get personalized support for your skin concerns',
      'buttonText': 'View Care',
      'image': 'assets/images/homecontainerimage.png',
    },
  ];

  final List<Map<String, dynamic>> _recentActivities = [
    {
      'title': 'AI Counseling session',
      'subtitle': 'Yesterday, 4:30 PM',
      'icon': Icons.chat_bubble,
    },
    {
      'title': 'Lunch Analysis',
      'subtitle': 'Yesterday, 4:30 PM',
      'icon': Icons.restaurant,
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (!_pageController.hasClients) return;
      setState(() {
        _currentPage = _pageController.page ?? 1;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _header(Size size) {
    return Row(
      children: [
        Container(
          width: size.width * 0.135,
          height: size.width * 0.135,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/images/profile1.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: size.width * 0.035),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome',
                style: TextStyle(
                  fontSize: size.width * 0.033,
                  fontFamily: "poppin",
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2D2D2D),
                  height: 1.1,
                ),
              ),
              SizedBox(height: size.height * 0.003),
              Text(
                'Henry wick!',
                style: TextStyle(
                  fontSize: size.width * 0.052,
                  fontFamily: "montserrat",
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF222222),
                  height: 1.1,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Notificationscreen()));
          },
          child: Container(
            width: size.width * 0.135,
            height: size.width * 0.135,
            decoration: const BoxDecoration(
              color: Color(0xFFE9F1FA),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications,
              color: const Color(0xFF3E8DDD),
              size: size.width * 0.075,
            ),
          ),
        ),
      ],
    );
  }

  Widget _featureCard(
      Map<String, String> item,
      Size size,
      bool isCenter,
      ) {
    final double cardHeight = isCenter
        ? size.height * 0.215
        : size.height * 0.195;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.015,
        vertical: isCenter ? size.height * 0.002 : size.height * 0.012,
      ),
      height: 171,
      decoration: BoxDecoration(
        color: const Color(0xFFEAF1F8),
        borderRadius: BorderRadius.circular(size.width * 0.09),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -size.height * 0.005,
            right: -size.width * 0.045,
            child: Container(
              width: size.width * 0.31,
              height: size.width * 0.31,
              decoration: const BoxDecoration(
                color: Color(0xFFDDE7F2),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.00,
            right: size.width * 0.00,
            child: Container(
              width: size.width * 0.18,
              height: size.width * 0.18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.width * 0.03),
                image: DecorationImage(
                  image: AssetImage(item['image']!),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.07,
              vertical: size.height * 0.03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: size.width * 0.50),
                Text(
                  item['title']!,
                  style: TextStyle(
                    fontSize: size.width * 0.037,
                    fontFamily: "montserrat",
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                    height: 1.15,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                SizedBox(
                  width: size.width * 0.4,
                  child: Text(
                    item['subtitle']!,
                    style: TextStyle(
                      fontSize: size.width * 0.022,
                      fontFamily: "poppin",
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2E2E2E),
                      height: 1.25,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Container(
                  height: 28,
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.03,
                    vertical: size.height * 0.010,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3E8DDD),
                    borderRadius: BorderRadius.circular(size.width * 0.08),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF3E8DDD).withOpacity(0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item['buttonText']!,
                        style: TextStyle(
                          fontSize: size.width * 0.023,
                          fontFamily: "poppin",
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: size.width * 0.02),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: size.width * 0.04,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _recentActivityTile(Map<String, dynamic> item, Size size) {
    return Container(
      height: size.height*0.09,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.06,
        vertical: size.height * 0.025,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF1F8),
        borderRadius: BorderRadius.circular(size.width * 0.055),
      ),
      child: Row(
        children: [
          Icon(
            item['icon'] as IconData,
            color: const Color(0xFF3E8DDD),
            size: size.width * 0.055,
          ),
          SizedBox(width: size.width * 0.045),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'] as String,
                  style: TextStyle(
                    fontSize: size.width * 0.027,
                    fontFamily: "montserrat",
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF7A7A7A),
                    height: 1.15,
                  ),
                ),
                SizedBox(height: size.height * 0.004),
                Text(
                  item['subtitle'] as String,
                  style: TextStyle(
                    fontSize: size.width * 0.022,
                    fontFamily: "poppin",
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF818181),
                    height: 1.15,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: size.width * 0.03),
          Icon(
            Icons.arrow_forward_ios,
            color: const Color(0xFF3E8DDD),
            size: size.width * 0.06,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.00,
            vertical: size.height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.height * 0.02,
                ),
                child: _header(size),
              ),
              SizedBox(height: size.height * 0.03),

              SizedBox(
                height: size.height * 0.22,
                width: double.infinity,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _featureCards.length,
                  itemBuilder: (context, index) {
                    final bool isCenter =
                        (_currentPage - index).abs() < 0.5;
                    return _featureCard(
                      _featureCards[index],
                      size,
                      isCenter,
                    );
                  },
                ),
              ),

              SizedBox(height: size.height * 0.030),

              Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.height * 0.02,),
                child: Text(
                  'Recent Activity',
                  style: TextStyle(
                    fontSize: size.width * 0.037,
                    fontFamily: "poppin",
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    height: 1.1,
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.023),

              ...List.generate(_recentActivities.length, (index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: size.height * 0.01,right: size.height*0.02,left: size.height*0.02),
                  child: _recentActivityTile(_recentActivities[index], size),
                );
              }),

              SizedBox(height: size.height * 0.12),
            ],
          ),
        ),
      ),
    );
  }
}