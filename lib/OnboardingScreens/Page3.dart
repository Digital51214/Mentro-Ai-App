import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Page3 extends StatefulWidget {
  final Function(bool) onNextEnabled;
  final Function(String, dynamic) onDataUpdate;
  final Function(VoidCallback) registerNextCallback;
  final Function(bool) setLoading;
  final VoidCallback navigateNext;

  const Page3({
    super.key,
    required this.onNextEnabled,
    required this.onDataUpdate,
    required this.registerNextCallback,
    required this.setLoading,
    required this.navigateNext,
  });

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final TextEditingController _currentWeightCtrl = TextEditingController();
  final TextEditingController _targetWeightCtrl = TextEditingController();

  final List<String> _weightUnits = ['KG', 'LB'];

  String _selectedCurrentWeightUnit = 'KG';
  String _selectedTargetWeightUnit = 'KG';

  String? _currentWeightError;
  String? _targetWeightError;

  @override
  void initState() {
    super.initState();
    widget.registerNextCallback(_handleNext);

    _currentWeightCtrl.addListener(_validateLive);
    _targetWeightCtrl.addListener(_validateLive);
  }

  @override
  void dispose() {
    _currentWeightCtrl.dispose();
    _targetWeightCtrl.dispose();
    super.dispose();
  }

  void _validateLive() {
    widget.onNextEnabled(_isFormValid());
  }

  bool _isFormValid() {
    return _currentWeightCtrl.text.trim().isNotEmpty &&
        _targetWeightCtrl.text.trim().isNotEmpty;
  }

  void _clearErrors() {
    _currentWeightError = null;
    _targetWeightError = null;
  }

  Future<void> _handleNext() async {
    FocusScope.of(context).unfocus();

    setState(() {
      _clearErrors();
    });

    bool valid = true;

    if (_currentWeightCtrl.text.trim().isEmpty) {
      _currentWeightError = 'Please enter current weight';
      valid = false;
    }

    if (_targetWeightCtrl.text.trim().isEmpty) {
      _targetWeightError = 'Please enter target weight';
      valid = false;
    }

    setState(() {});

    if (!valid) {
      widget.onNextEnabled(false);
      return;
    }

    widget.onDataUpdate('current_weight', _currentWeightCtrl.text.trim());
    widget.onDataUpdate(
        'current_weight_unit', _selectedCurrentWeightUnit.toLowerCase());

    widget.onDataUpdate('target_weight', _targetWeightCtrl.text.trim());
    widget.onDataUpdate(
        'target_weight_unit', _selectedTargetWeightUnit.toLowerCase());

    widget.navigateNext();
  }

  Widget _titleText(String text, Size size) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size.width * 0.06,
        fontFamily: "montserrat",
        fontWeight: FontWeight.w900,
        color: const Color(0xFF333333),
        height: 1.15,
      ),
    );
  }

  Widget _subtitleText(String text, Size size) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size.width * 0.032,
        fontFamily: "poppin",
        fontWeight: FontWeight.w700,
        color: const Color(0xFF7B7B7B),
        height: 1.4,
      ),
    );
  }

  Widget _sectionTitle(String text, Size size) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size.width * 0.032,
        fontFamily: "poppin",
        fontWeight: FontWeight.w800,
        color: const Color(0xFF4A4A4A),
      ),
    );
  }

  Widget _errorText(String? text, Size size) {
    if (text == null) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(
        left: size.width * 0.04,
        top: size.height * 0.005,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: size.width * 0.027,
          fontFamily: "poppin",
          color: Colors.red,
        ),
      ),
    );
  }

  Widget _weightField({
    required TextEditingController controller,
    required String hint,
    required String unit,
    required List<String> items,
    required ValueChanged<String> onSelected,
    required Size size,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.height * 0.058,
          child: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
            ],
            style: TextStyle(
              fontSize: size.width * 0.03,
              fontFamily: "poppin",
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: size.width * 0.03,
                fontFamily: "poppin",
                fontWeight: FontWeight.w700,
                color: const Color(0xFFB0B0B0),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: size.width * 0.045,
                vertical: size.height * 0.016,
              ),
              suffixIcon: Container(
                margin: EdgeInsets.only(
                  right: size.width * 0.025,
                  top: size.height * 0.010,
                  bottom: size.height * 0.010,
                ),
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.018),
                constraints: BoxConstraints(
                  minWidth: size.width * 0.16,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF3FB),
                  borderRadius: BorderRadius.circular(size.width * 0.05),
                ),
                child: PopupMenuButton<String>(
                  color: Colors.white,
                  onSelected: onSelected,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context) {
                    return items
                        .map(
                          (item) => PopupMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: size.width * 0.03,
                            fontFamily: "poppin",
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    )
                        .toList();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        unit,
                        style: TextStyle(
                          fontSize: size.width * 0.023,
                          fontFamily: "poppin",
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF3E8DDD),
                        ),
                      ),
                      SizedBox(width: size.width * 0.008),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: const Color(0xFF3E8DDD),
                        size: size.width * 0.045,
                      ),
                    ],
                  ),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.075),
                borderSide: BorderSide(
                  color:
                  errorText != null ? Colors.red : const Color(0xFFE2E2E2),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.075),
                borderSide: BorderSide(
                  color:
                  errorText != null ? Colors.red : const Color(0xFFE2E2E2),
                  width: 1,
                ),
              ),
            ),
          ),
        ),
        _errorText(errorText, size),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.055,
        vertical: size.height * 0.01,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.005),

          _titleText("Let’s set your target", size),
          SizedBox(height: size.height * 0.008),

          _subtitleText(
            "We will create a personalized plan based\non your goals",
            size,
          ),
          SizedBox(height: size.height * 0.03),

          _sectionTitle("Weight Details", size),
          SizedBox(height: size.height * 0.012),

          _weightField(
            controller: _currentWeightCtrl,
            hint: "Enter Current Weight...",
            unit: _selectedCurrentWeightUnit,
            items: _weightUnits,
            errorText: _currentWeightError,
            size: size,
            onSelected: (value) {
              setState(() {
                _selectedCurrentWeightUnit = value;
              });
            },
          ),
          SizedBox(height: size.height * 0.012),

          _weightField(
            controller: _targetWeightCtrl,
            hint: "Enter Target Weight...",
            unit: _selectedTargetWeightUnit,
            items: _weightUnits,
            errorText: _targetWeightError,
            size: size,
            onSelected: (value) {
              setState(() {
                _selectedTargetWeightUnit = value;
              });
            },
          ),

          SizedBox(height: size.height * 0.02),
        ],
      ),
    );
  }
}