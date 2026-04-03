import 'package:flutter/material.dart';

class Page6 extends StatefulWidget {
  final Function(bool) onNextEnabled;
  final Function(String, dynamic) onDataUpdate;
  final Function(VoidCallback) registerNextCallback;
  final Function(bool) setLoading;
  final VoidCallback navigateNext;

  const Page6({
    super.key,
    required this.onNextEnabled,
    required this.onDataUpdate,
    required this.registerNextCallback,
    required this.setLoading,
    required this.navigateNext,
  });

  @override
  State<Page6> createState() => _Page6State();
}

class _Page6State extends State<Page6> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool _dailyInsights = true;
  bool _aiReminders = true;
  bool _communityUpdates = true;

  @override
  void initState() {
    super.initState();
    widget.registerNextCallback(_handleNext);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onNextEnabled(true);
    });
  }

  Future<void> _handleNext() async {
    FocusScope.of(context).unfocus();

    widget.onDataUpdate('daily_insights', _dailyInsights);
    widget.onDataUpdate('ai_reminders', _aiReminders);
    widget.onDataUpdate('community_updates', _communityUpdates);

    widget.navigateNext();
  }

  Widget _titleText(Size size) {
    return Text(
      'Set Your Preferences',
      style: TextStyle(
        fontSize: size.width * 0.052,
        fontFamily: "semibold",
        fontWeight: FontWeight.w700,
        color: Colors.black,
        height: 1.1,
      ),
    );
  }

  Widget _subtitleText(Size size) {
    return Text(
      'Customize your experience for better\nsupport',
      style: TextStyle(
        fontSize: size.width * 0.036,
        fontFamily: "regular",
        fontWeight: FontWeight.w400,
        color: const Color(0xFF666666),
        height: 1.3,
      ),
    );
  }

  Widget _preferenceTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required Size size,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.014,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3FB),
        borderRadius: BorderRadius.circular(size.width * 0.035),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: size.width * 0.032,
                    fontFamily: "semibold",
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: size.height * 0.005),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: size.width * 0.024,
                    fontFamily: "regular",
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF7A7A7A),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: size.width * 0.02),
          Transform.scale(
            scale: 0.75,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.white,
              activeTrackColor: const Color(0xFF3E8DDD),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: const Color(0xFFBFC7CE),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final size = MediaQuery.of(context).size;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.055,
            vertical: size.height * 0.015,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.008),

              _titleText(size),
              SizedBox(height: size.height * 0.02),

              _subtitleText(size),
              SizedBox(height: size.height * 0.03),

              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.03,
                  vertical: size.height * 0.012,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF3FB),
                  borderRadius: BorderRadius.circular(size.width * 0.04),
                ),
                child: Column(
                  children: [
                    _preferenceTile(
                      title: 'Daily Insights',
                      subtitle: 'Morning Health Summary',
                      value: _dailyInsights,
                      onChanged: (value) {
                        setState(() {
                          _dailyInsights = value;
                        });
                      },
                      size: size,
                    ),
                    SizedBox(height: size.height * 0.004),
                    _preferenceTile(
                      title: 'AI Reminders',
                      subtitle: 'Timed Suggestions based on goal',
                      value: _aiReminders,
                      onChanged: (value) {
                        setState(() {
                          _aiReminders = value;
                        });
                      },
                      size: size,
                    ),
                    SizedBox(height: size.height * 0.004),
                    _preferenceTile(
                      title: 'Community Updates',
                      subtitle: 'Activity from shared wellness group',
                      value: _communityUpdates,
                      onChanged: (value) {
                        setState(() {
                          _communityUpdates = value;
                        });
                      },
                      size: size,
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.03),
            ],
          ),
        );
      },
    );
  }
}