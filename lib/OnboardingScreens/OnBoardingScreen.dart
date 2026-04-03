import 'package:flutter/material.dart';
import 'package:mentro_ai_app/MainBottomNavScreen/BottomNavigationScreen.dart';
import 'package:mentro_ai_app/MainBottomNavScreen/HomeScreen.dart';
import 'package:mentro_ai_app/OnboardingScreens/Page1.dart';
import 'package:mentro_ai_app/OnboardingScreens/Page2.dart';
import 'package:mentro_ai_app/OnboardingScreens/Page3.dart';
import 'package:mentro_ai_app/OnboardingScreens/Page4.dart';
import 'package:mentro_ai_app/OnboardingScreens/Page5.dart';
import 'package:mentro_ai_app/OnboardingScreens/Page6.dart';
import 'package:mentro_ai_app/Widgets/Backbutton.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 6;

  final Map<String, dynamic> _onboardingData = {};

  bool _isNextEnabled = false;
  bool _isLoading = false;
  bool _isTransitioning = false;

  final _callbackHolder = _CallbackHolder();

  void _goToNextPage() {
    if (_isTransitioning) return;

    final cb = _callbackHolder.callback;
    if (cb != null) {
      cb();
    } else {
      _navigateNext();
    }
  }

  void _navigateNext() {
    if (_isTransitioning) return;

    if (_currentPage < _totalPages - 1) {
      setState(() => _isTransitioning = true);

      _pageController
          .nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      )
          .then((_) {
        Future.delayed(const Duration(milliseconds: 50), () {
          if (mounted) {
            setState(() => _isTransitioning = false);
          }
        });
      });
    } else {
      // Last page — Get Started
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => BottomNavigationScreen()));
    }
  }

  void _goToPreviousPage() {
    if (_isTransitioning) return;

    if (_currentPage > 0) {
      // Agar current page pehla nahi — pichle page par jao
      setState(() => _isTransitioning = true);

      _pageController
          .previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      )
          .then((_) {
        Future.delayed(const Duration(milliseconds: 50), () {
          if (mounted) {
            setState(() => _isTransitioning = false);
          }
        });
      });
    } else {
      // Pehla page hai — login screen par wapas jao
      Navigator.of(context).pop();
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
      _callbackHolder.callback = null;
      _isNextEnabled = false;
    });
  }

  void _updateNextEnabled(bool enabled) {
    if (_isNextEnabled != enabled) {
      setState(() => _isNextEnabled = enabled);
    }
  }

  void _updateData(String key, dynamic value) {
    setState(() => _onboardingData[key] = value);
  }

  void _registerNextCallback(VoidCallback callback) {
    _callbackHolder.callback = callback;
  }

  void _setLoading(bool loading) {
    if (_isLoading != loading) {
      setState(() => _isLoading = loading);
    }
  }

  bool get _isFinalPage => _currentPage == _totalPages - 1;
  bool get _nextActive => _isNextEnabled && !_isTransitioning;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/onboardingScreenBackground.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  size.width * 0.05,
                  size.height * 0.04,
                  size.width * 0.05,
                  0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // FIX: onTap mein _goToPreviousPage pass kiya
                    // Page 1 par: Navigator.pop() — login wapas
                    // Page 2-6 par: pichla onboarding page
                    CustomBackButton(onTap: _goToPreviousPage),
                    Image.asset(
                      'assets/images/logo.png',
                      height: size.height * 0.07,
                      width: size.width * 0.14,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.015),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Step ${_currentPage + 1} of $_totalPages',
                      style: TextStyle(
                        fontSize: size.width * 0.035,
                        fontFamily: "medium",
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: size.height * 0.012),
                    Row(
                      children: List.generate(_totalPages, (index) {
                        return Expanded(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeInOut,
                            margin: EdgeInsets.only(
                              right: index < _totalPages - 1
                                  ? size.width * 0.015
                                  : 0,
                            ),
                            height: 4,
                            decoration: BoxDecoration(
                              color: index <= _currentPage
                                  ? const Color(0xff3B8EDB)
                                  : Colors.white70,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.015),

              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: _onPageChanged,
                  children: [
                    Page1(
                      onNextEnabled: _updateNextEnabled,
                      onDataUpdate: _updateData,
                      registerNextCallback: _registerNextCallback,
                      setLoading: _setLoading,
                      navigateNext: _navigateNext,
                    ),
                    Page2(
                      onNextEnabled: _updateNextEnabled,
                      onDataUpdate: _updateData,
                      registerNextCallback: _registerNextCallback,
                      setLoading: _setLoading,
                      navigateNext: _navigateNext,
                    ),
                    Page3(
                      onNextEnabled: _updateNextEnabled,
                      onDataUpdate: _updateData,
                      registerNextCallback: _registerNextCallback,
                      setLoading: _setLoading,
                      navigateNext: _navigateNext,
                    ),
                    Page4(
                      onNextEnabled: _updateNextEnabled,
                      onDataUpdate: _updateData,
                      registerNextCallback: _registerNextCallback,
                      setLoading: _setLoading,
                      navigateNext: _navigateNext,
                    ),
                    Page5(
                      onNextEnabled: _updateNextEnabled,
                      onDataUpdate: _updateData,
                      registerNextCallback: _registerNextCallback,
                      setLoading: _setLoading,
                      navigateNext: _navigateNext,
                    ),
                    Page6(
                      onNextEnabled: _updateNextEnabled,
                      onDataUpdate: _updateData,
                      registerNextCallback: _registerNextCallback,
                      setLoading: _setLoading,
                      navigateNext: _navigateNext,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(
                  size.width * 0.05,
                  size.height * 0.01,
                  size.width * 0.05,
                  size.height * 0.03,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: _nextActive && !_isLoading ? _goToNextPage : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff3B8EDB),
                      padding: EdgeInsets.zero,
                      disabledBackgroundColor: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : Text(
                      _isFinalPage ? 'Get Started!' : 'Next',
                      style: TextStyle(
                        fontSize: size.width * 0.03,
                        fontFamily: "bold",
                        fontWeight: FontWeight.w600,
                        color: _nextActive
                            ? Colors.white
                            : Colors.grey[500],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CallbackHolder {
  VoidCallback? callback;
}
