import 'package:flutter/material.dart';
import 'package:mentro_ai_app/AuthonticationScreens/LoginScreen.dart';
import 'package:mentro_ai_app/Widgets/Backbutton.dart';
import 'package:mentro_ai_app/Widgets/ElevatedButton1.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmVisible = false;

  String? _passwordError;
  String? _confirmError;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _handleChangePassword() {
    setState(() {
      _passwordError = null;
      _confirmError = null;
    });

    bool isValid = true;

    if (_passwordController.text.trim().isEmpty) {
      setState(() => _passwordError = 'Please enter password');
      isValid = false;
    } else if (_passwordController.text.trim().length < 6) {
      setState(() => _passwordError = 'Password must be at least 6 characters');
      isValid = false;
    }

    if (_confirmController.text.trim().isEmpty) {
      setState(() => _confirmError = 'Please confirm password');
      isValid = false;
    } else if (_confirmController.text.trim() !=
        _passwordController.text.trim()) {
      setState(() => _confirmError = 'Passwords do not match');
      isValid = false;
    }

    if (!isValid) return;

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => SignInScreen()),
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CustomBackButton(),
                    SizedBox(width: size.width * 0.03),
                    const Expanded(
                      child: Text(
                        'Change',
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: "montserrat",
                          fontWeight: FontWeight.w900,
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
                    'Change Password',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: "montserrat",
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        style: TextStyle(
                          fontSize: size.width * 0.028,
                          fontFamily: "poppin",
                        ),
                        onChanged: (_) {
                          if (_passwordError != null) {
                            setState(() => _passwordError = null);
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Password...',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: size.width * 0.023,
                            fontFamily: "poppin",
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 12,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color(0xff3A8DD9),
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          errorStyle:
                          const TextStyle(fontSize: 0, height: 0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: _passwordError != null
                                  ? Colors.red
                                  : Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: _passwordError != null
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
                    if (_passwordError != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 4),
                        child: Text(
                          _passwordError!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 11,
                            fontFamily: "regular",
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: TextFormField(
                        controller: _confirmController,
                        obscureText: !_isConfirmVisible,
                        style: TextStyle(
                          fontSize: size.width * 0.027,
                          fontFamily: "poppin",
                        ),
                        onChanged: (_) {
                          if (_confirmError != null) {
                            setState(() => _confirmError = null);
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Confirm Password...',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: size.width * 0.023,
                            fontFamily: "poppin",
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 12,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color(0xff3A8DD9),
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmVisible = !_isConfirmVisible;
                              });
                            },
                          ),
                          errorStyle:
                          const TextStyle(fontSize: 0, height: 0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: _confirmError != null
                                  ? Colors.red
                                  : Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: _confirmError != null
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
                    if (_confirmError != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 4),
                        child: Text(
                          _confirmError!,
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
               ElevatedButton1(text: "Change", onPressed: (){
                 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SignInScreen()),
                     (Route<dynamic>route)=>false);
               }),
                SizedBox(height: size.height * 0.06),
              ],
            ),
          ),
        ),
      ),
    );
  }
}