import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  final Function(bool) onNextEnabled;
  final Function(String, dynamic) onDataUpdate;
  final Function(VoidCallback) registerNextCallback;
  final Function(bool) setLoading;
  final VoidCallback navigateNext;

  const Page2({
    super.key,
    required this.onNextEnabled,
    required this.onDataUpdate,
    required this.registerNextCallback,
    required this.setLoading,
    required this.navigateNext,
  });

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String? _selectedGoal;

  final List<Map<String, dynamic>> _goalOptions = const [
    {
      'id': 'mental_wellness',
      'title': 'Mental Wellness',
      'icon': Icons.psychology_alt_rounded,
    },
    {
      'id': 'nutrition_weight_loss',
      'title': 'Nutrition & Weight loss',
      'icon': Icons.balance_rounded,
    },
    {
      'id': 'skin_care',
      'title': 'Skin Care',
      'icon': Icons.spa_rounded,
    },
    {
      'id': 'general_health_support',
      'title': 'General Health Support',
      'icon': Icons.medical_services_rounded,
    },
  ];

  @override
  void initState() {
    super.initState();
    widget.registerNextCallback(_handleNext);
    widget.onNextEnabled(false);
  }

  void _selectGoal(String id) {
    setState(() {
      _selectedGoal = id;
    });

    widget.onDataUpdate('selected_goal', id);
    widget.onNextEnabled(true);
  }

  void _handleNext() {
    if (_selectedGoal == null) return;
    widget.navigateNext();
  }

  Widget _titleText(Size size) {
    return Text(
      'What goals do you want to\nachieve?',
      style: TextStyle(
        fontSize: size.width * 0.052,
        fontFamily: "montserrat",
        fontWeight: FontWeight.w900,
        color: Colors.black,
        height: 1.15,
      ),
    );
  }

  Widget _subtitleText(Size size) {
    return Text(
      'Select what you want Mentro AI to help\nyou with',
      style: TextStyle(
        fontSize: size.width * 0.036,
        fontFamily: "poppin",
        fontWeight: FontWeight.w700,
        color: const Color(0xFF666666),
        height: 1.4,
      ),
    );
  }

  Widget _goalCard(Map<String, dynamic> item, Size size) {
    final bool isSelected = _selectedGoal == item['id'];

    return GestureDetector(
      onTap: () => _selectGoal(item['id']),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.045,
          vertical: size.height * 0.020,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFFDFDFD),
          borderRadius: BorderRadius.circular(size.width * 0.065),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF3E8DDD)
                : const Color(0xFFD0D0D0),
            width: isSelected ? 1.6 : 1.2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: size.width * 0.13,
              height: size.width * 0.13,
              decoration: const BoxDecoration(
                color: Color(0xFFE2EEF9),
                shape: BoxShape.circle,
              ),
              child: Icon(
                item['icon'] as IconData,
                size: size.width * 0.085,
                color: const Color(0xFF3E8DDD),
              ),
            ),
            SizedBox(width: size.width * 0.045),
            Expanded(
              child: Text(
                item['title'],
                style: TextStyle(
                  fontSize: size.width * 0.033,
                  fontFamily: "poppin",
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                  height: 1.2,
                ),
              ),
            ),
            SizedBox(width: size.width * 0.02),
            Text(
              isSelected ? 'Selected' : 'Select',
              style: TextStyle(
                fontSize: size.width * 0.027,
                fontFamily: "poppin",
                fontWeight: FontWeight.w800,
                color: const Color(0xFF3E8DDD),
              ),
            ),
          ],
        ),
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
                _titleText(size),
                SizedBox(height: size.height * 0.015),
                _subtitleText(size),
                SizedBox(height: size.height * 0.03),

                ...List.generate(_goalOptions.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.01),
                    child: _goalCard(_goalOptions[index], size),
                  );
                }),

                SizedBox(height: size.height * 0.02),
              ],
            ),
          );
        }
    );
  }
}