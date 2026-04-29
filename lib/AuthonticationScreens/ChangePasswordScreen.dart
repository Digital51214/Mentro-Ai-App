import 'package:flutter/material.dart';
import 'package:mentro_ai_app/OtherPresentationScreen/AccountSettingScreen.dart';
import 'package:mentro_ai_app/Widgets/Backbutton.dart';
import 'package:mentro_ai_app/Widgets/ElevatedButton1.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
  TextEditingController();

  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmNewPasswordVisible = false;

  String? _oldPasswordError;
  String? _newPasswordError;
  String? _confirmNewPasswordError;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  void _handleChangePassword() {
    setState(() {
      _oldPasswordError = null;
      _newPasswordError = null;
      _confirmNewPasswordError = null;
    });

    bool isValid = true;

    if (_oldPasswordController.text.trim().isEmpty) {
      setState(() => _oldPasswordError = 'Please enter old password');
      isValid = false;
    } else if (_oldPasswordController.text.trim().length < 6) {
      setState(
            () => _oldPasswordError = 'Old password must be at least 6 characters',
      );
      isValid = false;
    }

    if (_newPasswordController.text.trim().isEmpty) {
      setState(() => _newPasswordError = 'Please enter new password');
      isValid = false;
    } else if (_newPasswordController.text.trim().length < 6) {
      setState(
            () => _newPasswordError = 'New password must be at least 6 characters',
      );
      isValid = false;
    }

    if (_confirmNewPasswordController.text.trim().isEmpty) {
      setState(
            () => _confirmNewPasswordError = 'Please confirm new password',
      );
      isValid = false;
    } else if (_confirmNewPasswordController.text.trim() !=
        _newPasswordController.text.trim()) {
      setState(
            () => _confirmNewPasswordError = 'Passwords do not match',
      );
      isValid = false;
    }

    if (!isValid) return;

    // Add your change password API or navigation here
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
                        'Change Password',
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
                      fontFamily: "poppin",
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.01),

                /// Old Password
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: TextFormField(
                        controller: _oldPasswordController,
                        obscureText: !_isOldPasswordVisible,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: size.width * 0.03,
                          fontFamily: "poppin",
                          fontWeight: FontWeight.w700,
                        ),
                        onChanged: (_) {
                          if (_oldPasswordError != null) {
                            setState(() => _oldPasswordError = null);
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Old Password...',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: size.width * 0.03,
                            fontFamily: "poppin",
                            fontWeight: FontWeight.w700,
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 12,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isOldPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color(0xff3A8DD9),
                              size: size.width * 0.055,
                            ),
                            onPressed: () {
                              setState(() {
                                _isOldPasswordVisible = !_isOldPasswordVisible;
                              });
                            },
                          ),
                          errorStyle: const TextStyle(fontSize: 0, height: 0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: _oldPasswordError != null
                                  ? Colors.red
                                  : Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: _oldPasswordError != null
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
                    if (_oldPasswordError != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 4),
                        child: Text(
                          _oldPasswordError!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 11,
                            fontFamily: "poppin",
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 5),

                /// New Password
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: TextFormField(
                        controller: _newPasswordController,
                        obscureText: !_isNewPasswordVisible,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: size.width * 0.03,
                          fontFamily: "poppin",
                          fontWeight: FontWeight.w700,
                        ),
                        onChanged: (_) {
                          if (_newPasswordError != null) {
                            setState(() => _newPasswordError = null);
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'New Password...',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: size.width * 0.03,
                            fontFamily: "poppin",
                            fontWeight: FontWeight.w700,
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 12,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isNewPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color(0xff3A8DD9),
                              size: size.width * 0.055,
                            ),
                            onPressed: () {
                              setState(() {
                                _isNewPasswordVisible = !_isNewPasswordVisible;
                              });
                            },
                          ),
                          errorStyle: const TextStyle(fontSize: 0, height: 0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: _newPasswordError != null
                                  ? Colors.red
                                  : Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: _newPasswordError != null
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
                    if (_newPasswordError != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 4),
                        child: Text(
                          _newPasswordError!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 11,
                            fontFamily: "poppin",
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 5),

                /// Confirm New Password
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: TextFormField(
                        controller: _confirmNewPasswordController,
                        obscureText: !_isConfirmNewPasswordVisible,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: size.width * 0.03,
                          fontFamily: "poppin",
                          fontWeight: FontWeight.w700,
                        ),
                        onChanged: (_) {
                          if (_confirmNewPasswordError != null) {
                            setState(() => _confirmNewPasswordError = null);
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Confirm New Password...',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: size.width * 0.03,
                            fontFamily: "poppin",
                            fontWeight: FontWeight.w700,
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 12,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmNewPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color(0xff3A8DD9),
                              size: size.width * 0.055,
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmNewPasswordVisible =
                                !_isConfirmNewPasswordVisible;
                              });
                            },
                          ),
                          errorStyle: const TextStyle(fontSize: 0, height: 0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: _confirmNewPasswordError != null
                                  ? Colors.red
                                  : Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: _confirmNewPasswordError != null
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
                    if (_confirmNewPasswordError != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 4),
                        child: Text(
                          _confirmNewPasswordError!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 11,
                            fontFamily: "poppin",
                          ),
                        ),
                      ),
                  ],
                ),

                SizedBox(height: size.height * 0.04),

                ElevatedButton1(
                  text: "Change",
                  // onPressed: _handleChangePassword,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountSettingsScreen()));
                  },
                ),

                SizedBox(height: size.height * 0.06),
              ],
            ),
          ),
        ),
      ),
    );
  }
}