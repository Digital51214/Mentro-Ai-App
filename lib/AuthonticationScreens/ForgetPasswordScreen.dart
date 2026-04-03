import 'package:flutter/material.dart';
import 'package:mentro_ai_app/AuthonticationScreens/VerifyScreen.dart';
import 'package:mentro_ai_app/Widgets/Backbutton.dart';
import 'package:mentro_ai_app/Widgets/ElevatedButton1.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  String? _emailError;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleResetPassword() {
    setState(() => _emailError = null);

    bool isValid = true;

    if (_emailController.text.trim().isEmpty) {
      setState(() => _emailError = 'Please enter your email');
      isValid = false;
    } else if (!_emailController.text.contains('@')) {
      setState(() => _emailError = 'Please enter a valid email');
      isValid = false;
    }

    if (!isValid) return;

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => VerifyScreen()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.06,
            vertical: size.height * 0.02,
          ),
          child: _buildFormView(theme, size),
        ),
      ),
    );
  }

  Widget _buildFormView(ThemeData theme, Size size) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomBackButton(),
              SizedBox(width: size.width * 0.03),
              const Expanded(
                child: Text(
                  'Forget Password',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "semibold",
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    height: 1.1,
                  ),
                ),
              ),
              Container(
                height: size.height * 0.07,
                width: size.width * 0.16,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    image: AssetImage("assets/images/logo.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.07),
          Center(
            child: Container(
              height: size.height * 0.21,
              width: size.width * 0.37,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/verifyimage.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.06),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Verify Your Identity',
              style: TextStyle(
                fontSize: 24,
                fontFamily: "bold",
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Enter email to find your account',
              style: TextStyle(
                fontSize: 14,
                fontFamily: "regular",
                color: Colors.black54,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.03),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 45,
                width: double.infinity,
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    fontSize: size.width * 0.03,
                    fontFamily: "regular",
                  ),
                  onChanged: (_) {
                    if (_emailError != null) {
                      setState(() => _emailError = null);
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Email Address',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: size.width * 0.025,
                      fontFamily: "regular",
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),
                    errorStyle: const TextStyle(fontSize: 0, height: 0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: _emailError != null
                            ? Colors.red
                            : Colors.grey.shade300,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: _emailError != null
                            ? Colors.red
                            : const Color(0xff3A8DD9),
                        width: 1.2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                    ),
                  ),
                  validator: (_) => null,
                ),
              ),
              if (_emailError != null)
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 4),
                  child: Text(
                    _emailError!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 11,
                      fontFamily: "regular",
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: size.height * 0.04),
         ElevatedButton1(text: "Find Your Account", onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyScreen()));

         }),
          SizedBox(height: size.height * 0.06),
        ],
      ),
    );
  }
}