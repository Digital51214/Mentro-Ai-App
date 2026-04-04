import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentro_ai_app/AuthonticationScreens/UpdatePasswordScreen.dart';
import 'package:mentro_ai_app/Widgets/Backbutton.dart';
import 'package:mentro_ai_app/Widgets/ElevatedButton1.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final _formKey = GlobalKey<FormState>();

  final List<TextEditingController> _otpControllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _otpFocusNodes = List.generate(6, (_) => FocusNode());

  String? _otpError;

  @override
  void dispose() {
    for (var c in _otpControllers) {
      c.dispose();
    }
    for (var n in _otpFocusNodes) {
      n.dispose();
    }
    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    String text = value;

    if (text.length > 1) {
      text = text.substring(text.length - 1);
      _otpControllers[index].text = text;
    }

    if (text.isNotEmpty) {
      if (index + 1 < _otpFocusNodes.length) {
        _otpFocusNodes[index + 1].requestFocus();
      } else {
        _otpFocusNodes[index].unfocus();
      }
    } else {
      if (index - 1 >= 0) {
        _otpFocusNodes[index - 1].requestFocus();
      }
    }

    _otpControllers[index].selection = TextSelection.fromPosition(
      TextPosition(offset: _otpControllers[index].text.length),
    );

    if (_otpError != null) {
      setState(() => _otpError = null);
    } else {
      setState(() {});
    }
  }

  String get _enteredOtp => _otpControllers.map((c) => c.text.trim()).join();

  void _handleVerify() {
    setState(() => _otpError = null);

    if (_enteredOtp.length < 6) {
      setState(() => _otpError = 'Please enter the complete 6-digit code');
      return;
    }

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
    // );
  }

  Widget _buildOtpBox(int index, double boxSize) {
    return SizedBox(
      width: boxSize,
      height: boxSize * 1.3,
      child: Stack(
        alignment: Alignment.center,
        children: [
          TextFormField(
            controller: _otpControllers[index],
            focusNode: _otpFocusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            style: const TextStyle(
              color: Colors.transparent,
              fontSize: 17,
              fontFamily: "poppinbold",
              fontWeight: FontWeight.w700,
            ),
            cursorColor: const Color(0xff3A8DD9),
            maxLength: 1,
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              errorStyle: const TextStyle(fontSize: 0, height: 0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _otpError != null
                      ? Colors.red
                      : Colors.grey.shade300,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _otpError != null
                      ? Colors.red
                      : const Color(0xff3A8DD9),
                  width: 1.4,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1.0,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1.4,
                ),
              ),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (val) => _onOtpChanged(val, index),
          ),
          _otpControllers[index].text.isNotEmpty
              ? Text(
            _otpControllers[index].text,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: "semibold",
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          )
              : SizedBox(
            width: boxSize * 0.01,
            height: boxSize * 0.01,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final double boxSize = size.width * 0.12;

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
                        'Verify',
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
                    'Enter Code',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: "montserrat",
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter code to verify your Identity',
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: "poppin",
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.022),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (i) {
                        return _buildOtpBox(i, boxSize);
                      }),
                    ),
                    if (_otpError != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 4, top: 6),
                        child: Text(
                          _otpError!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 11,
                            fontFamily: "poppin",
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: size.height * 0.035),
                ElevatedButton1(text: "Verify", onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePasswordScreen()));
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