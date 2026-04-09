import 'package:flutter/material.dart';
import 'package:mentro_ai_app/MainBottomNavScreen/BottomNavigationScreen.dart';
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

  bool _isLoading = false;
  bool _isTransitioning = false;

  // Track next-enabled state per page
  final List<bool> _pageNextEnabled = [false, false, false, false, false, true];

  // Store registered next callbacks per page
  final List<VoidCallback?> _nextCallbacks = [null, null, null, null, null, null];

  void _goToNextPage() {
    if (_isTransitioning || _isLoading) return;
    // Call the current page's registered next callback (handles validation + navigate)
    final cb = _nextCallbacks[_currentPage];
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => BottomNavigationScreen()),
      );
    }
  }

  void _goToPreviousPage() {
    if (_isTransitioning) return;

    if (_currentPage > 0) {
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
      Navigator.of(context).pop();
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  // FIX: Now properly updates per-page next state
  void _updateNextEnabled(bool enabled) {
    if (_pageNextEnabled[_currentPage] != enabled) {
      setState(() {
        _pageNextEnabled[_currentPage] = enabled;
      });
    }
  }

  void _updateData(String key, dynamic value) {
    setState(() => _onboardingData[key] = value);
  }

  // FIX: Store callback against specific page index at registration time
  void _registerNextCallback(VoidCallback callback) {
    _nextCallbacks[_currentPage] = callback;
  }

  void _setLoading(bool loading) {
    if (_isLoading != loading) {
      setState(() => _isLoading = loading);
    }
  }

  bool get _isFinalPage => _currentPage == _totalPages - 1;

  // FIX: Button active based on per-page state
  bool get _nextActive =>
      !_isTransitioning && !_isLoading && _pageNextEnabled[_currentPage];

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
              image: AssetImage("assets/images/onboardingimage2.png"),
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
                        fontSize: size.width * 0.033,
                        fontFamily: "poppin",
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w800,
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
                      onNextEnabled: (enabled) {
                        if (_pageNextEnabled[0] != enabled) {
                          setState(() => _pageNextEnabled[0] = enabled);
                        }
                      },
                      onDataUpdate: _updateData,
                      registerNextCallback: (cb) => _nextCallbacks[0] = cb,
                      setLoading: _setLoading,
                      navigateNext: _navigateNext,
                    ),
                    Page2(
                      onNextEnabled: (enabled) {
                        if (_pageNextEnabled[1] != enabled) {
                          setState(() => _pageNextEnabled[1] = enabled);
                        }
                      },
                      onDataUpdate: _updateData,
                      registerNextCallback: (cb) => _nextCallbacks[1] = cb,
                      setLoading: _setLoading,
                      navigateNext: _navigateNext,
                    ),
                    Page3(
                      onNextEnabled: (enabled) {
                        if (_pageNextEnabled[2] != enabled) {
                          setState(() => _pageNextEnabled[2] = enabled);
                        }
                      },
                      onDataUpdate: _updateData,
                      registerNextCallback: (cb) => _nextCallbacks[2] = cb,
                      setLoading: _setLoading,
                      navigateNext: _navigateNext,
                    ),
                    Page4(
                      onNextEnabled: (enabled) {
                        if (_pageNextEnabled[3] != enabled) {
                          setState(() => _pageNextEnabled[3] = enabled);
                        }
                      },
                      onDataUpdate: _updateData,
                      registerNextCallback: (cb) => _nextCallbacks[3] = cb,
                      setLoading: _setLoading,
                      navigateNext: _navigateNext,
                    ),
                    Page5(
                      onNextEnabled: (enabled) {
                        if (_pageNextEnabled[4] != enabled) {
                          setState(() => _pageNextEnabled[4] = enabled);
                        }
                      },
                      onDataUpdate: _updateData,
                      registerNextCallback: (cb) => _nextCallbacks[4] = cb,
                      setLoading: _setLoading,
                      navigateNext: _navigateNext,
                    ),
                    Page6(
                      onNextEnabled: (enabled) {
                        if (_pageNextEnabled[5] != enabled) {
                          setState(() => _pageNextEnabled[5] = enabled);
                        }
                      },
                      onDataUpdate: _updateData,
                      registerNextCallback: (cb) => _nextCallbacks[5] = cb,
                      setLoading: _setLoading,
                      navigateNext: _navigateNext,
                    ),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xffF3F3F3),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                padding: EdgeInsets.fromLTRB(
                  size.width * 0.05,
                  size.height * 0.02,
                  size.width * 0.05,
                  size.height * 0.04,
                ),
                child: Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: size.height * 0.058,
                    child: ElevatedButton(
                      onPressed: _nextActive ? _goToNextPage : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff3B8EDB),
                        padding: EdgeInsets.zero,
                        disabledBackgroundColor:
                        const Color(0xff3B8EDB).withOpacity(0.45),
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
                          fontFamily: "poppinbold",
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
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