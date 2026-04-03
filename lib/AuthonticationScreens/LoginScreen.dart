import 'package:flutter/material.dart';
import 'package:mentro_ai_app/AuthonticationScreens/ForgetPasswordScreen.dart';
import 'package:mentro_ai_app/AuthonticationScreens/SignUpScreen.dart';
import 'package:mentro_ai_app/MainBottomNavScreen/BottomNavigationScreen.dart';
import 'package:mentro_ai_app/OnboardingScreens/OnBoardingScreen.dart';
import 'package:mentro_ai_app/Widgets/ElevatedButton1.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _rememberMe = false;

  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    bool isValid = true;

    if (_emailController.text.trim().isEmpty) {
      _emailError = 'Please enter your email';
      isValid = false;
    } else if (!_emailController.text.contains('@')) {
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

    setState(() {});

    if (!isValid) return;

    // Navigator.of(context).pushReplacementNamed(AppRoutes.subscriptionCheckout);
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
                        'Sign In',
                        style: TextStyle(
                          fontSize: size.width * 0.06,
                          fontWeight: FontWeight.w700,
                          fontFamily: "semibold",
                          color: Colors.black,
                          height: 1.2,
                        ),
                      ),
                    ),

                    SizedBox(height: size.height * 0.007),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Welcome Back! Enter Your Account Details',
                        style: TextStyle(
                          fontSize: size.width * 0.03,
                          fontWeight: FontWeight.w400,
                          fontFamily: "regular",
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    SizedBox(height: size.height * 0.035),

                    _buildEmailField(size),

                    SizedBox(height: size.height * 0.006),

                    _buildPasswordField(size),

                    SizedBox(height: size.height * 0.018),

                    _buildRememberForgotRow(size),

                    SizedBox(height: size.height * 0.035),
                    ElevatedButton1(text: "Sign In", onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>OnboardingScreen()));
                    }),
                    SizedBox(height: size.height * 0.13),

                    _buildSignUpPrompt(size),

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

  Widget _buildEmailField(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.height * 0.058,
          child: TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
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
                fontSize: size.width * 0.025,
                fontFamily: "regular",
                fontWeight: FontWeight.w400,
              ),
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.022,
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
          child: TextFormField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
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
                fontSize: size.width * 0.025,
                fontFamily: "regular",
                fontWeight: FontWeight.w400,
              ),
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.022,
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

  Widget _buildRememberForgotRow(Size size) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _rememberMe = !_rememberMe;
            });
          },
          child: Row(
            children: [
              Container(
                width: size.width * 0.045,
                height: size.width * 0.045,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black54,
                    width: 1,
                  ),
                  color: _rememberMe
                      ? const Color(0xff3A8DD9)
                      : Colors.transparent,
                ),
                child: _rememberMe
                    ? Icon(
                  Icons.check,
                  size: size.width * 0.03,
                  color: Colors.white,
                )
                    : null,
              ),
              SizedBox(width: size.width * 0.02),
              Text(
                'Remember Me',
                style: TextStyle(
                  fontSize: size.width * 0.025,
                  fontFamily: "regular",
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordScreen()));
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Forget Password?',
            style: TextStyle(
              fontSize: size.width * 0.025,
              fontFamily: "semibold",
              color: const Color(0xff3A8DD9),
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
              decorationColor: const Color(0xff3A8DD9),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpPrompt(Size size) {
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            "Don't have an account? ",
            style: TextStyle(
              fontSize: size.width * 0.035,
              fontFamily: "regular",
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SignUpScreen()),
                  (Route<dynamic>route)=>false);
            },
            child: Text(
              'Sign Up',
              style: TextStyle(
                fontSize: size.width * 0.035,
                fontFamily: "semibold",
                color: const Color(0xff3A8DD9),
                fontWeight: FontWeight.w700,
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