import 'package:flutter/material.dart';

class Page4 extends StatefulWidget {
  final Function(bool) onNextEnabled;
  final Function(String, dynamic) onDataUpdate;
  final Function(VoidCallback) registerNextCallback;
  final Function(bool) setLoading;
  final VoidCallback navigateNext;

  const Page4({
    super.key,
    required this.onNextEnabled,
    required this.onDataUpdate,
    required this.registerNextCallback,
    required this.setLoading,
    required this.navigateNext,
  });

  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String? _selectedActivity;
  String? _activityError;

  final List<Map<String, String>> _activityLevels = [
    {
      'id': 'sedentary',
      'title': 'Sedentary',
      'subtitle': 'Little or no exercise',
    },
    {
      'id': 'light_active',
      'title': 'Light active',
      'subtitle': 'Light exercise 1-3 days/week',
    },
    {
      'id': 'moderately_active',
      'title': 'Moderately Active',
      'subtitle': 'Moderate exercise 3-5 days/week',
    },
    {
      'id': 'very_active',
      'title': 'Very Active',
      'subtitle': 'Hard exercise 6-7 days/week',
    },
    {
      'id': 'extremely_active',
      'title': 'Extremely Active',
      'subtitle': 'Very hard exercise & physical job',
    },
  ];

  @override
  void initState() {
    super.initState();
    widget.registerNextCallback(_handleNext);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onNextEnabled(_isFormValid());
    });
  }

  bool _isFormValid() {
    return _selectedActivity != null;
  }

  void _clearErrors() {
    _activityError = null;
  }

  void _selectActivity(String id) {
    setState(() {
      _selectedActivity = id;
      _activityError = null;
    });

    widget.onNextEnabled(_isFormValid());
  }

  Future<void> _handleNext() async {
    FocusScope.of(context).unfocus();

    setState(() {
      _clearErrors();
    });

    bool valid = true;

    if (_selectedActivity == null) {
      _activityError = 'Please choose your activity level';
      valid = false;
    }

    setState(() {});

    if (!valid) {
      widget.onNextEnabled(false);
      return;
    }

    widget.onDataUpdate('activity_level', _selectedActivity);
    widget.navigateNext();
  }

  Widget _titleText(String text, Size size) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size.width * 0.05,
        fontFamily: "montserrat",
        fontWeight: FontWeight.w900,
        color: Colors.black,
        height: 1.1,
      ),
    );
  }

  Widget _subtitleText(String text, Size size) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size.width * 0.034,
        fontFamily: "poppin",
        fontWeight: FontWeight.w700,
        color: const Color(0xFF666666),
        height: 1.3,
      ),
    );
  }

  Widget _errorText(String? text, Size size) {
    if (text == null) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(
        left: size.width * 0.02,
        top: size.height * 0.006,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: size.width * 0.03,
          fontFamily: "poppin",
          color: Colors.red,
        ),
      ),
    );
  }

  Widget _activityCard({
    required Map<String, String> item,
    required bool isSelected,
    required Size size,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        height: 66,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.06,
          vertical: size.height * 0.022,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF3E8DDD).withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(size.width * 0.06),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF3B8EDB)
                : const Color(0xFFD9D9D9),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 19,
              height: 19,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected? const Color(0xFF3B8EDD): Colors.black,
                  width: 1.4,
                ),
              ),
              child: isSelected
                  ? Center(
                child: Container(
                  width: size.width*0.13,
                  height: size.width*0.13,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF3B8EDD),
                  ),
                  child: Icon(Icons.check,size: size.width*0.04,color: Colors.white,),
                ),
              )
                  : null,
            ),
            SizedBox(width: size.width * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] ?? '',
                    style: TextStyle(
                      fontSize: size.width * 0.027,
                      fontFamily: "poppin",
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      height: 1.15,
                    ),
                  ),
                  SizedBox(height: size.width * 0.007),
                  Text(
                    item['subtitle'] ?? '',
                    style: TextStyle(
                      fontSize: size.width * 0.023,
                      fontFamily: "poppin",
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF8E8E8E),
                      height: 1.2,
                    ),
                  ),
                ],
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

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.055,
        vertical: size.height * 0.015,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.01),

          _titleText('Activity Level', size),
          SizedBox(height: size.height * 0.015),

          _subtitleText('Please choose your activity level', size),
          SizedBox(height: size.height * 0.04),

          ...List.generate(_activityLevels.length, (index) {
            final item = _activityLevels[index];
            final isSelected = _selectedActivity == item['id'];

            return Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.01),
              child: _activityCard(
                item: item,
                isSelected: isSelected,
                size: size,
                onTap: () => _selectActivity(item['id']!),
              ),
            );
          }),

          _errorText(_activityError, size),
          SizedBox(height: size.height * 0.02),
        ],
      ),
    );
  }
}