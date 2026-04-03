import 'package:flutter/material.dart';

class Page5 extends StatefulWidget {
  final Function(bool) onNextEnabled;
  final Function(String, dynamic) onDataUpdate;
  final Function(VoidCallback) registerNextCallback;
  final Function(bool) setLoading;
  final VoidCallback navigateNext;

  const Page5({
    super.key,
    required this.onNextEnabled,
    required this.onDataUpdate,
    required this.registerNextCallback,
    required this.setLoading,
    required this.navigateNext,
  });

  @override
  State<Page5> createState() => _Page5State();
}

class _Page5State extends State<Page5> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String? _selectedSkinConcern;
  final List<String> _allergies = ['Gluten'];

  final List<String> _availableAllergies = const [
    'Gluten',
    'Dairy',
    'Eggs',
    'Peanuts',
    'Tree Nuts',
    'Soy',
    'Fish',
    'Shellfish',
    'Sesame',
    'Wheat',
    'Corn',
    'Chocolate',
    'Strawberries',
    'Tomatoes',
    'Caffeine',
  ];

  final List<Map<String, dynamic>> _skinConcernOptions = const [
    {
      'id': 'acne',
      'title': 'Acne',
      'icon': Icons.psychology_alt_rounded,
    },
    {
      'id': 'dryness',
      'title': 'Dryness',
      'icon': Icons.balance_rounded,
    },
    {
      'id': 'sensitivity',
      'title': 'Sensitivity',
      'icon': Icons.medical_services_rounded,
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
    return _selectedSkinConcern != null;
  }

  void _selectSkinConcern(String id) {
    setState(() {
      _selectedSkinConcern = id;
    });

    widget.onNextEnabled(_isFormValid());
  }

  void _removeAllergy(String allergy) {
    setState(() {
      _allergies.remove(allergy);
    });
  }

  void _addAllergy(String allergy) {
    if (_allergies.contains(allergy)) return;

    setState(() {
      _allergies.add(allergy);
    });
  }

  Future<void> _showAllergyPicker() async {
    final List<String> remainingAllergies = _availableAllergies
        .where((allergy) => !_allergies.contains(allergy))
        .toList();

    if (remainingAllergies.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All allergies already added'),
        ),
      );
      return;
    }

    final String? selected = await showDialog<String>(
      context: context,
      builder: (context) {
        final size = MediaQuery.of(context).size;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size.width * 0.05),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: size.height * 0.025,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Allergy',
                  style: TextStyle(
                    fontSize: size.width * 0.05,
                    fontFamily: "semibold",
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: size.height * 0.4,
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: remainingAllergies.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final allergy = remainingAllergies[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          allergy,
                          style: TextStyle(
                            fontSize: size.width * 0.04,
                            fontFamily: "medium",
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context, allergy);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (selected != null) {
      _addAllergy(selected);
    }
  }

  Future<void> _handleNext() async {
    FocusScope.of(context).unfocus();

    if (_selectedSkinConcern == null) {
      widget.onNextEnabled(false);
      return;
    }

    widget.onDataUpdate('skin_concern', _selectedSkinConcern);
    widget.onDataUpdate('allergies', _allergies);

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

  Widget _sectionTitle(String text, Size size) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size.width * 0.04,
        fontFamily: "semibold",
        fontWeight: FontWeight.w700,
        color: Colors.black,
        height: 1.15,
      ),
    );
  }

  Widget _skinConcernCard({
    required Map<String, dynamic> item,
    required bool isSelected,
    required Size size,
  }) {
    return GestureDetector(
      onTap: () => _selectSkinConcern(item['id']),
      child: Container(
        height: 80,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.045,
          vertical: size.height * 0.022,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF3E8DDD).withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(size.width * 0.07),
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
                size: size.width * 0.078,
                color: const Color(0xFF3E8DDD),
              ),
            ),
            SizedBox(width: size.width * 0.045),
            Expanded(
              child: Text(
                item['title'],
                style: TextStyle(
                  fontSize: size.width * 0.04,
                  fontFamily: "semibold",
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  height: 1.2,
                ),
              ),
            ),
            SizedBox(width: size.width * 0.02),
            Text(
              isSelected ? 'Selected' : 'Select',
              style: TextStyle(
                fontSize: size.width * 0.032,
                fontFamily: "medium",
                fontWeight: FontWeight.w500,
                color: const Color(0xFF3E8DDD),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _allergyChip(String text, Size size) {
    return Container(
      height: 30,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.012,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF3E8DDD),
        borderRadius: BorderRadius.circular(size.width * 0.05),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: size.width * 0.02,
              fontFamily: "medium",
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          SizedBox(width: size.width * 0.02),
          GestureDetector(
            onTap: () => _removeAllergy(text),
            child: Icon(
              Icons.close,
              size: size.width * 0.030,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _addButton(Size size) {
    return GestureDetector(
      onTap: _showAllergyPicker,
      child: Container(
        width: size.width * 0.08,
        height: size.width * 0.08,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFF3E8DDD),
            width: 1.4,
          ),
        ),
        child: Center(
          child: Icon(
            Icons.add,
            color: const Color(0xFF3E8DDD),
            size: size.width * 0.04,
          ),
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
              SizedBox(height: size.height * 0.008),

              _titleText(size),
              SizedBox(height: size.height * 0.015),

              _subtitleText(size),
              SizedBox(height: size.height * 0.02),

              _sectionTitle('Skin Concerns', size),
              SizedBox(height: size.height * 0.02),

              ...List.generate(_skinConcernOptions.length, (index) {
                final item = _skinConcernOptions[index];
                final isSelected = _selectedSkinConcern == item['id'];

                return Padding(
                  padding: EdgeInsets.only(bottom: size.height * 0.01),
                  child: _skinConcernCard(
                    item: item,
                    isSelected: isSelected,
                    size: size,
                  ),
                );
              }),

              SizedBox(height: size.height * 0.02),

              _sectionTitle('Allergies', size),
              SizedBox(height: size.height * 0.02),

              Wrap(
                spacing: size.width * 0.03,
                runSpacing: size.height * 0.015,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  ..._allergies.map((allergy) => _allergyChip(allergy, size)),
                  _addButton(size),
                ],
              ),

              SizedBox(height: size.height * 0.03),
            ],
          ),
        );
      },
    );
  }
}