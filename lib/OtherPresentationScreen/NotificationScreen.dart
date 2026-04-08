import 'package:flutter/material.dart';
import 'package:mentro_ai_app/Widgets/Backbutton.dart';

class Notificationscreen extends StatefulWidget {
  const Notificationscreen({super.key});

  @override
  State<Notificationscreen> createState() => _NotificationscreenState();
}

class _NotificationscreenState extends State<Notificationscreen> {
  // ─── Dummy notification data ────────────────────────────────────
  final List<Map<String, String>> _notifications = [
    {
      'title': 'Notifications',
      'subtitle': 'Your Beats Notifications......',
      'time': '10 min Ago',
    },
    {
      'title': 'Notifications',
      'subtitle': 'Your Beats Notifications......',
      'time': '10 min Ago',
    },
    {
      'title': 'Notifications',
      'subtitle': 'Your Beats Notifications......',
      'time': '10 min Ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double w = size.width;
    final double h = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.05),
          child: Column(
            children: [
              SizedBox(height: h * 0.03),

              // ─── AppBar Row ──────────────────────────────────────
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Back button
                  CustomBackButton(),

                  SizedBox(width: w * 0.05),

                  // Title
                  Expanded(
                    child: Text(
                      'Notifications',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "montserrat",
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  // Logo
                  Container(
                    height: h * 0.07,
                    width: w * 0.16,
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

              SizedBox(height: h * 0.03),

              // ─── Notification List ───────────────────────────────
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _notifications.length,
                  separatorBuilder: (_, __) => SizedBox(height: h * 0.01),
                  itemBuilder: (context, index) {
                    final item = _notifications[index];
                    return _notificationCard(
                      title: item['title']!,
                      subtitle: item['subtitle']!,
                      time: item['time']!,
                      w: w,
                      h: h,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Notification Card Widget ────────────────────────────────────
  Widget _notificationCard({
    required String title,
    required String subtitle,
    required String time,
    required double w,
    required double h,
  }) {
    return Container(
      height: h*0.096,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: w * 0.04,
        vertical: h * 0.022,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF2FB),
        borderRadius: BorderRadius.circular(w * 0.05),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Bell Icon ──────────────────────────────────────────
          Icon(
            Icons.notifications_active,
            color: Colors.black,
            size: w * 0.08,
          ),

          SizedBox(width: w * 0.04),

          // ── Title + Subtitle ───────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: w * 0.027,
                    fontFamily: "poppin",
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: h * 0.004),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: w * 0.023,
                    fontFamily: "poppin",
                    fontWeight: FontWeight.w700,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),

          // ── Time ──────────────────────────────────────────────
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: w * 0.016,
                height: w * 0.016,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF4A90D9),
                ),
              ),
              SizedBox(width: w * 0.014),
              Text(
                time,
                style: TextStyle(
                  fontSize: w * 0.023,
                  fontFamily: "poppin",
                  fontWeight: FontWeight.w700,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}