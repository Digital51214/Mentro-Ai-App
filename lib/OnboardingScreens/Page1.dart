import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Page1 extends StatefulWidget {
  final Function(bool) onNextEnabled;
  final Function(String, dynamic) onDataUpdate;
  final Function(VoidCallback) registerNextCallback;
  final Function(bool) setLoading;
  final VoidCallback navigateNext;

  const Page1({
    super.key,
    required this.onNextEnabled,
    required this.onDataUpdate,
    required this.registerNextCallback,
    required this.setLoading,
    required this.navigateNext,
  });

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _dobCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _ageCtrl = TextEditingController();
  final TextEditingController _heightCtrl = TextEditingController();

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _ageUnits = ['Yrs', 'Mon'];
  final List<String> _heightUnits = ['Cm', 'Ft'];

  late final List<String> _countries;

  String? _selectedCountry;
  String? _selectedGender;
  String _selectedAgeUnit = 'Yrs';
  String _selectedHeightUnit = 'Cm';
  DateTime? _selectedDate;

  String? _nameError;
  String? _dobError;
  String? _phoneError;
  String? _countryError;
  String? _genderError;
  String? _ageError;
  String? _heightError;

  @override
  void initState() {
    super.initState();
    widget.registerNextCallback(_handleNext);

    _countries = CountryService().getAll().map((country) => country.name).toList();

    _nameCtrl.addListener(_validateLive);
    _dobCtrl.addListener(_validateLive);
    _phoneCtrl.addListener(_validateLive);
    _ageCtrl.addListener(_validateLive);
    _heightCtrl.addListener(_validateLive);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _dobCtrl.dispose();
    _phoneCtrl.dispose();
    _ageCtrl.dispose();
    _heightCtrl.dispose();
    super.dispose();
  }

  void _validateLive() {
    widget.onNextEnabled(_isFormValid());
  }

  bool _isFormValid() {
    return _nameCtrl.text.trim().isNotEmpty &&
        _dobCtrl.text.trim().isNotEmpty &&
        _phoneCtrl.text.trim().isNotEmpty &&
        _selectedCountry != null &&
        _selectedGender != null &&
        _ageCtrl.text.trim().isNotEmpty &&
        _heightCtrl.text.trim().isNotEmpty;
  }

  void _clearErrors() {
    _nameError = null;
    _dobError = null;
    _phoneError = null;
    _countryError = null;
    _genderError = null;
    _ageError = null;
    _heightError = null;
  }

  Future<void> _handleNext() async {
    FocusScope.of(context).unfocus();

    bool valid = _nameCtrl.text.trim().isNotEmpty &&
        _dobCtrl.text.trim().isNotEmpty &&
        _phoneCtrl.text.trim().isNotEmpty &&
        _selectedCountry != null &&
        _selectedGender != null &&
        _ageCtrl.text.trim().isNotEmpty &&
        _heightCtrl.text.trim().isNotEmpty;

    if (!valid) {
      setState(() {
        _nameError =
        _nameCtrl.text.trim().isEmpty ? 'Please enter full name' : null;
        _dobError = _dobCtrl.text.trim().isEmpty
            ? 'Please select date of birth'
            : null;
        _phoneError = _phoneCtrl.text.trim().isEmpty
            ? 'Please enter phone number'
            : null;
        _countryError =
        _selectedCountry == null ? 'Please select country' : null;
        _genderError =
        _selectedGender == null ? 'Please select gender' : null;
        _ageError = _ageCtrl.text.trim().isEmpty ? 'Please enter age' : null;
        _heightError =
        _heightCtrl.text.trim().isEmpty ? 'Please enter height' : null;
      });
      widget.onNextEnabled(false);
      return;
    }

    setState(() {
      _clearErrors();
    });

    widget.onDataUpdate('full_name', _nameCtrl.text.trim());
    widget.onDataUpdate('date_of_birth', _dobCtrl.text.trim());
    widget.onDataUpdate('phone_number', _phoneCtrl.text.trim());
    widget.onDataUpdate('country', _selectedCountry);
    widget.onDataUpdate('gender', _selectedGender);
    widget.onDataUpdate('age', _ageCtrl.text.trim());
    widget.onDataUpdate('age_unit', _selectedAgeUnit);
    widget.onDataUpdate('height', _heightCtrl.text.trim());
    widget.onDataUpdate('height_unit', _selectedHeightUnit);

    widget.navigateNext();
  }

  Future<void> _pickDate() async {
    FocusScope.of(context).unfocus();

    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18),
      firstDate: DateTime(1950),
      lastDate: now,
    );

    if (picked != null) {
      final text =
          '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';

      setState(() {
        _selectedDate = picked;
        _dobCtrl.text = text;
        _dobError = null;
      });

      widget.onNextEnabled(_isFormValid());
    }
  }

  Widget _titleText(String text, Size size) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size.width * 0.052,
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
        fontSize: size.width * 0.032,
        fontFamily: "poppin",
        fontWeight: FontWeight.w700,
        color: const Color(0xFF666666),
        height: 1.35,
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

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    required Size size,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    Widget? suffixIcon,
    String? errorText,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.height * 0.058,
          child: TextField(
            controller: controller,
            readOnly: readOnly,
            onTap: onTap,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            style: TextStyle(
              fontSize: size.width * 0.037,
              fontFamily: "poppin",
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: size.width * 0.028,
                fontFamily: "poppin",
                fontWeight: FontWeight.w700,
                color: const Color(0xFF8E8E8E),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
                vertical: size.height * 0.028,
              ),
              suffixIcon: suffixIcon,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.075),
                borderSide: BorderSide(
                  color: errorText != null
                      ? Colors.red
                      : const Color(0xFFD3D3D3),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.075),
                borderSide: BorderSide(
                  color: errorText != null
                      ? Colors.red
                      : const Color(0xFFD3D3D3),
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

  Widget _popupSelectField({
    required String value,
    required String hint,
    required List<String> items,
    required ValueChanged<String> onSelected,
    required Size size,
    String? errorText,
  }) {
    final bool hasValue = value.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: size.height * 0.058,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          decoration: BoxDecoration(
            color: const Color(0xFFEAF3FB),
            borderRadius: BorderRadius.circular(size.width * 0.075),
            border: Border.all(
              color: errorText != null ? Colors.red : const Color(0xFFD3D3D3),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  hasValue ? value : hint,
                  style: TextStyle(
                    fontSize: size.width * 0.037,
                    fontFamily: "poppin",
                    fontWeight: FontWeight.w800,
                    color: const Color(0xff3B8EDB),
                  ),
                ),
              ),
              PopupMenuButton<String>(
                color: Colors.white,
                onSelected: onSelected,
                itemBuilder: (context) {
                  return items
                      .map(
                        (item) => PopupMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: size.width * 0.036,
                          fontFamily: "poppin",
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  )
                      .toList();
                },
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: const Color(0xff3B8EDB),
                  size: size.width * 0.075,
                ),
              ),
            ],
          ),
        ),
        _errorText(errorText, size),
      ],
    );
  }

  Widget _countryField({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String> onSelected,
    required Size size,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: size.height * 0.058,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          decoration: BoxDecoration(
            color: const Color(0xFFEAF3FB),
            borderRadius: BorderRadius.circular(size.width * 0.075),
            border: Border.all(
              color: errorText != null ? Colors.red : const Color(0xFFD3D3D3),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value ?? hint,
                  style: TextStyle(
                    fontSize: size.width * 0.037,
                    fontFamily: "poppin",
                    fontWeight: FontWeight.w800,
                    color: const Color(0xff3B8EDB),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              PopupMenuButton<String>(
                color: Colors.white,
                constraints: BoxConstraints(
                  minWidth: size.width * 0.89,
                  maxWidth: size.width * 0.89,
                  maxHeight: size.height * 0.45,
                ),
                onSelected: onSelected,
                itemBuilder: (context) {
                  return items
                      .map(
                        (item) => PopupMenuItem<String>(
                      value: item,
                      child: SizedBox(
                        width: size.width * 0.78,
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: size.width * 0.036,
                            fontFamily: "poppin",
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  )
                      .toList();
                },
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: const Color(0xff3B8EDB),
                  size: size.width * 0.075,
                ),
              ),
            ],
          ),
        ),
        _errorText(errorText, size),
      ],
    );
  }

  Widget _unitField({
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
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: TextStyle(
              fontSize: size.width * 0.037,
              fontFamily: "poppin",
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: size.width * 0.038,
                fontFamily: "poppin",
                fontWeight: FontWeight.w700,
                color: const Color(0xFF8E8E8E),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
                vertical: size.height * 0.018,
              ),
              suffixIcon: Container(
                margin: EdgeInsets.only(
                  right: size.width * 0.03,
                  top: size.height * 0.01,
                  bottom: size.height * 0.01,
                ),
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                constraints: BoxConstraints(
                  minWidth: size.width * 0.18,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF3FB),
                  borderRadius: BorderRadius.circular(size.width * 0.06),
                ),
                child: PopupMenuButton<String>(
                  color: Colors.white,
                  onSelected: onSelected,
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                  itemBuilder: (context) {
                    return items
                        .map(
                          (item) => PopupMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: size.width * 0.036,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        unit,
                        style: TextStyle(
                          fontSize: size.width * 0.028,
                          fontFamily: "poppin",
                          fontWeight: FontWeight.w800,
                          color: const Color(0xff3B8EDB),
                        ),
                      ),
                      SizedBox(width: size.width * 0.01),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: const Color(0xff3B8EDB),
                        size: size.width * 0.06,
                      ),
                    ],
                  ),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.075),
                borderSide: BorderSide(
                  color: errorText != null
                      ? Colors.red
                      : const Color(0xFFD3D3D3),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.075),
                borderSide: BorderSide(
                  color: errorText != null
                      ? Colors.red
                      : const Color(0xFFD3D3D3),
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

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.055,
            vertical: size.height * 0.018,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleText('Basic Information', size),
              SizedBox(height: size.height * 0.01),
              _subtitleText('Please enter basic information', size),
              SizedBox(height: size.height * 0.03),

              _textField(
                controller: _nameCtrl,
                hint: 'Full Name...',
                errorText: _nameError,
                size: size,
              ),
              SizedBox(height: size.height * 0.012),

              _textField(
                controller: _dobCtrl,
                hint: 'Date of birth...',
                readOnly: true,
                onTap: _pickDate,
                errorText: _dobError,
                size: size,
                suffixIcon: IconButton(
                  onPressed: _pickDate,
                  icon: Icon(
                    Icons.calendar_month_outlined,
                    color: const Color(0xff3B8EDB),
                    size: size.width * 0.06,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.012),

              _textField(
                controller: _phoneCtrl,
                hint: 'Phone number....',
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                errorText: _phoneError,
                size: size,
              ),
              SizedBox(height: size.height * 0.012),

              _countryField(
                value: _selectedCountry,
                hint: 'Select Country / Region',
                errorText: _countryError,
                size: size,
                items: _countries,
                onSelected: (value) {
                  setState(() {
                    _selectedCountry = value;
                    _countryError = null;
                  });
                  widget.onNextEnabled(_isFormValid());
                },
              ),
              SizedBox(height: size.height * 0.012),

              _popupSelectField(
                value: _selectedGender ?? '',
                hint: 'Gender',
                errorText: _genderError,
                size: size,
                items: _genders,
                onSelected: (value) {
                  setState(() {
                    _selectedGender = value;
                    _genderError = null;
                  });
                  widget.onNextEnabled(_isFormValid());
                },
              ),
              SizedBox(height: size.height * 0.012),

              _unitField(
                controller: _ageCtrl,
                hint: 'Age...',
                unit: _selectedAgeUnit,
                errorText: _ageError,
                size: size,
                items: _ageUnits,
                onSelected: (value) {
                  setState(() {
                    _selectedAgeUnit = value;
                  });
                },
              ),
              SizedBox(height: size.height * 0.012),

              _unitField(
                controller: _heightCtrl,
                hint: 'Height....',
                unit: _selectedHeightUnit,
                errorText: _heightError,
                size: size,
                items: _heightUnits,
                onSelected: (value) {
                  setState(() {
                    _selectedHeightUnit = value;
                  });
                },
              ),
              SizedBox(height: size.height * 0.02),
            ],
          ),
        );
      },
    );
  }
}