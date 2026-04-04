import 'package:flutter/material.dart';
import 'package:mentro_ai_app/AuthonticationScreens/LoginScreen.dart';
import 'package:mentro_ai_app/AuthonticationScreens/PrivacyPolicyScreen.dart';
import 'package:mentro_ai_app/AuthonticationScreens/Terms&ConditionScreen.dart';
import 'package:mentro_ai_app/Widgets/ElevatedButton1.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  bool _isAgreed = true;

  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    setState(() {
      _nameError = null;
      _emailError = null;
      _passwordError = null;
      _confirmPasswordError = null;
    });

    bool isValid = true;

    if (_nameController.text.trim().isEmpty) {
      _nameError = 'Please enter your name';
      isValid = false;
    }

    if (_emailController.text.trim().isEmpty) {
      _emailError = 'Please enter your email';
      isValid = false;
    } else if (!_emailController.text.contains('@') ||
        !_emailController.text.contains('.')) {
      _emailError = 'Please enter a valid email';
      isValid = false;
    }

    if (_passwordController.text.trim().isEmpty) {
      _passwordError = 'Please enter your password';
      isValid = false;
    } else if (_passwordController.text.length < 6) {
      _passwordError = 'Password must be at least 6 characters';
      isValid = false;
    }

    if (_confirmPasswordController.text.trim().isEmpty) {
      _confirmPasswordError = 'Please confirm your password';
      isValid = false;
    } else if (_confirmPasswordController.text != _passwordController.text) {
      _confirmPasswordError = 'Passwords do not match';
      isValid = false;
    }

    setState(() {});

    if (!isValid) return;

    if (!_isAgreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please agree to the Terms & Conditions and Privacy Policy.',
            style: TextStyle(fontFamily: "regular"),
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Navigator.of(context).pushReplacementNamed(AppRoutes.signIn);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height - topPadding,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
                vertical: size.height * 0.01,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.07),

                    _buildTopLogo(size),

                    SizedBox(height: size.height * 0.05),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: size.width * 0.06,
                          fontWeight: FontWeight.w700,
                          fontFamily: "montserrat",
                          color: Colors.black,
                          height: 1.2,
                        ),
                      ),
                    ),

                    SizedBox(height: size.height * 0.007),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Enter Your Details to SignUp',
                        style: TextStyle(
                          fontSize: size.width * 0.027,
                          fontWeight: FontWeight.w700,
                          fontFamily: "poppin",
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    SizedBox(height: size.height * 0.03),

                    _buildNameField(size),

                    SizedBox(height: size.height * 0.006),

                    _buildEmailField(size),

                    SizedBox(height: size.height * 0.006),

                    _buildPasswordField(size),

                    SizedBox(height: size.height * 0.006),

                    _buildConfirmPasswordField(size),

                    SizedBox(height: size.height * 0.01),

                    _buildTermsRow(size),

                    SizedBox(height: size.height * 0.03),

                    ElevatedButton1(text: "Sign Up", onPressed: (){
                      Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context)=>SignInScreen()),
                          (Route<dynamic>route)=>false
                      );
                    }),

                    SizedBox(height: size.height * 0.05),

                    _buildSignInPrompt(size),

                    SizedBox(height: size.height * 0.02),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopLogo(Size size) {
    return Center(
      child: Container(
        height: size.height * 0.24,
        width: size.width * 0.5,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage("assets/images/logo.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildNameField(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.height * 0.058,
          width: double.infinity,
          child: TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.name,
            style: TextStyle(
              fontSize: size.width * 0.033,
              fontFamily: "poppin",
              color: Colors.black,
            ),
            onChanged: (_) {
              if (_nameError != null) {
                setState(() {
                  _nameError = null;
                });
              }
            },
            decoration: InputDecoration(
              hintText: 'Username...',
              hintStyle: TextStyle(
                color: Colors.grey.shade500,
                fontSize: size.width * 0.023,
                fontFamily: "poppin",
                fontWeight: FontWeight.w700,
              ),
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.02,
              ),
              errorStyle: const TextStyle(fontSize: 0, height: 0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.08),
                borderSide: BorderSide(
                  color: _nameError != null ? Colors.red : Colors.grey.shade300,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.08),
                borderSide: BorderSide(
                  color: _nameError != null
                      ? Colors.red
                      : const Color(0xff3A8DD9),
                  width: 1.2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.08),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.08),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
            ),
            validator: (_) => null,
          ),
        ),
        if (_nameError != null)
          Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.04,
              top: size.height * 0.005,
            ),
            child: Text(
              _nameError!,
              style: TextStyle(
                color: Colors.red,
                fontSize: size.width * 0.028,
                fontFamily: "regular",
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildEmailField(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.height * 0.058,
          width: double.infinity,
          child: TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              fontSize: size.width * 0.033,
              fontFamily: "poppin",
              color: Colors.black,
            ),
            onChanged: (_) {
              if (_emailError != null) {
                setState(() {
                  _emailError = null;
                });
              }
            },
            decoration: InputDecoration(
              hintText: 'Email Address...',
              hintStyle: TextStyle(
                color: Colors.grey.shade500,
                fontSize: size.width * 0.023,
                fontFamily: "poppin",
                fontWeight: FontWeight.w700,
              ),
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.02,
              ),
              errorStyle: const TextStyle(fontSize: 0, height: 0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.08),
                borderSide: BorderSide(
                  color: _emailError != null
                      ? Colors.red
                      : Colors.grey.shade300,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.08),
                borderSide: BorderSide(
                  color: _emailError != null
                      ? Colors.red
                      : const Color(0xff3A8DD9),
                  width: 1.2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.08),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.08),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
            ),
            validator: (_) => null,
          ),
        ),
        if (_emailError != null)
          Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.04,
              top: size.height * 0.005,
            ),
            child: Text(
              _emailError!,
              style: TextStyle(
                color: Colors.red,
                fontSize: size.width * 0.028,
                fontFamily: "regular",
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPasswordField(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.height * 0.058,
          width: double.infinity,
          child: TextFormField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            style: TextStyle(
              fontSize: size.width * 0.033,
              fontFamily: "poppin",
              color: Colors.black,
            ),
            onChanged: (_) {
              if (_passwordError != null) {
                setState(() {
                  _passwordError = null;
                });
              }
            },
            decoration: InputDecoration(
              hintText: 'Password...',
              hintStyle: TextStyle(
                color: Colors.grey.shade500,
                fontSize: size.width * 0.023,
                fontFamily: "poppin",
                fontWeight: FontWeight.w400,
              ),
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.02,
              ),
              errorStyle: const TextStyle(fontSize: 0, height: 0),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xff3A8DD9),
                  size: size.width * 0.055,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.08),
                borderSide: BorderSide(
                  color: _passwordError != null
                      ? Colors.red
                      : Colors.grey.shade300,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.08),
                borderSide: BorderSide(
                  color: _passwordError != null
                      ? Colors.red
                      : const Color(0xff3A8DD9),
                  width: 1.2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.08),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.08),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
            ),
            validator: (_) => null,
          ),
        ),
        if (_passwordError != null)
          Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.04,
              top: size.height * 0.005,
            ),
            child: Text(
              _passwordError!,
              style: TextStyle(
                color: Colors.red,
                fontSize: size.width * 0.028,
                fontFamily: "regular",
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildConfirmPasswordField(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.height * 0.058,
          width: double.infinity,
          child: TextFormField(
            controller: _confirmPasswordController,
            obscureText: !_isConfirmPasswordVisible,
            style: TextStyle(
              fontSize: size.width * 0.033,
              fontFamily: "poppin",
              color: Colors.black,
            ),
            onChanged: (_) {
              if (_confirmPasswordError != null) {
                setState(() {
                  _confirmPasswordError = null;
                });
              }
            },
            decoration: InputDecoration(
              hintText: 'Confirm Password...',
              hintStyle: TextStyle(
                color: Colors.grey.shade500,
                fontSize: size.width * 0.023,
                fontFamily: "poppin",
                fontWeight: FontWeight.w400,
              ),
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.02,
              ),
              errorStyle: const TextStyle(fontSize: 0, height: 0),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  });
                },
                icon: Icon(
                  _isConfirmPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: const Color(0xff3A8DD9),
                  size: size.width * 0.055,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.08),
                borderSide: BorderSide(
                  color: _confirmPasswordError != null
                      ? Colors.red
                      : Colors.grey.shade300,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.08),
                borderSide: BorderSide(
                  color: _confirmPasswordError != null
                      ? Colors.red
                      : const Color(0xff3A8DD9),
                  width: 1.2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.08),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width * 0.08),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
            ),
            validator: (_) => null,
          ),
        ),
        if (_confirmPasswordError != null)
          Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.04,
              top: size.height * 0.005,
            ),
            child: Text(
              _confirmPasswordError!,
              style: TextStyle(
                color: Colors.red,
                fontSize: size.width * 0.028,
                fontFamily: "regular",
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTermsRow(Size size) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isAgreed = !_isAgreed;
            });
          },
          child: Container(
            width: size.width * 0.045,
            height: size.width * 0.045,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xff3A8DD9),
                width: 1,
              ),
              color: _isAgreed
                  ? const Color(0xff3A8DD9)
                  : Colors.transparent,
            ),
            child: _isAgreed
                ? Icon(
              Icons.check,
              size: size.width * 0.03,
              color: Colors.white,
            )
                : null,
          ),
        ),
        SizedBox(width: size.width * 0.02),
        Expanded(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'I agree with all ',
                style: TextStyle(
                  fontSize: size.width * 0.021,
                  fontFamily: "inter",
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                 onTap: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                        builder: (context) => TermsAndConditions(),
                     ),
                  );
                },
                child: Text(
                  'Terms & Conditions',
                  style: TextStyle(
                    fontSize: size.width * 0.0215,
                    fontFamily: "inter",
                    color: const Color(0xff3A8DD9),
                    fontWeight: FontWeight.w900,
                    decoration: TextDecoration.underline,
                    decorationColor: const Color(0xff3A8DD9),
                  ),
                ),
              ),
              Text(
                ' and ',
                style: TextStyle(
                  fontSize: size.width * 0.022,
                  fontFamily: "inter",
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                        builder: (context) => PrivacyPolicy(),
                     ),
                   );
                },
                child: Text(
                  'Privacy Policy',
                  style: TextStyle(
                    fontSize: size.width * 0.0215,
                    fontFamily: "inter",
                    color: const Color(0xff3A8DD9),
                    fontWeight: FontWeight.w900,
                    decoration: TextDecoration.underline,
                    decorationColor: const Color(0xff3A8DD9),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildSignInPrompt(Size size) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            'Already have an account? ',
            style: TextStyle(
              fontSize: size.width * 0.033,
              fontFamily: "poppin",
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          GestureDetector(
            onTap: () {
               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SignInScreen()),
                   (Route<dynamic>route)=>false);
            },
            child: Text(
              'Sign In',
              style: TextStyle(
                fontSize: size.width * 0.033,
                fontFamily: "poppin",
                color: const Color(0xff3A8DD9),
                fontWeight: FontWeight.w800,
                decoration: TextDecoration.underline,
                decorationColor: const Color(0xff3A8DD9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}