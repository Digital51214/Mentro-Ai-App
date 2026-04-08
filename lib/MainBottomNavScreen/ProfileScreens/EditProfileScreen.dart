import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentro_ai_app/MainBottomNavScreen/BottomNavigationScreen.dart';
import 'package:mentro_ai_app/MainBottomNavScreen/ProfileScreens/MainProfileScreen.dart';
import 'package:mentro_ai_app/Widgets/Backbutton.dart';
import 'package:mentro_ai_app/Widgets/ElevatedButton1.dart';

class Editprofilescreen extends StatefulWidget {
  const Editprofilescreen({super.key});

  @override
  State<Editprofilescreen> createState() => _EditprofilescreenState();
}

class _EditprofilescreenState extends State<Editprofilescreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController =
  TextEditingController(text: 'Henry Wick');
  final TextEditingController _emailController =
  TextEditingController(text: 'Example@mail.com');

  File? _selectedImage;
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // ─── Open Camera or Gallery ─────────────────────────────────────
  Future<void> _openImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: source,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 85,
    );
    if (pickedFile != null && mounted) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // ─── Image Source Button (same style as provided code) ──────────
  Widget _imageSourceButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required double w,
    required double h,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: w * 0.18,
            height: w * 0.18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF4A90D9).withOpacity(0.08),
              border: Border.all(
                color: const Color(0xFF4A90D9),
                width: 1.2,
              ),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF4A90D9),
              size: w * 0.065,
            ),
          ),
          SizedBox(height: h * 0.01),
          Text(
            label,
            style: TextStyle(
              fontSize: w * 0.033,
              fontWeight: FontWeight.w800,
              fontFamily: "poppin",
              color: const Color(0xFF1A1A2E),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Bottom Sheet (same structure as provided code) ─────────────
  void _pickImage() {
    final size = MediaQuery.of(context).size;
    final double w = size.width;
    final double h = size.height;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.06,
              vertical: h * 0.03,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Drag handle ──────────────────────────────────
                Container(
                  width: w * 0.14,
                  height: h * 0.006,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                SizedBox(height: h * 0.025),

                // ── Title ────────────────────────────────────────
                Text(
                  'Select Image Source',
                  style: TextStyle(
                    fontSize: w * 0.046,
                    fontWeight: FontWeight.w900,
                    fontFamily: "montserrat",
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: h * 0.03),

                // ── Camera & Gallery buttons ──────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _imageSourceButton(
                      icon: Icons.camera_alt,
                      label: 'Camera',
                      w: w,
                      h: h,
                      onTap: () async {
                        Navigator.pop(context);
                        await _openImage(ImageSource.camera);
                      },
                    ),
                    SizedBox(width: w * 0.08),
                    _imageSourceButton(
                      icon: Icons.photo_library,
                      label: 'Gallery',
                      w: w,
                      h: h,
                      onTap: () async {
                        Navigator.pop(context);
                        await _openImage(ImageSource.gallery);
                      },
                    ),
                  ],
                ),
                SizedBox(height: h * 0.02),
              ],
            ),
          ),
        );
      },
    );
  }

  // ─── Avatar Image Provider ──────────────────────────────────────
  ImageProvider _buildAvatarImage() {
    if (_selectedImage != null) {
      return FileImage(_selectedImage!);
    }
    return const AssetImage('assets/images/avatar_placeholder.png');
  }

  // ─── Save / Update ──────────────────────────────────────────────
  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(seconds: 1)); // simulate API call
    if (mounted) {
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Profile updated successfully',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          backgroundColor: const Color(0xFF4A90D9),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double w = size.width;
    final double h = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.055),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: h * 0.04),

                // ─── AppBar Row ────────────────────────────────────
                Row(
                  children: [
                    CustomBackButton(),
                     SizedBox(width: w*0.05,),
                     Center(
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontSize: w * 0.053,
                            fontWeight: FontWeight.w900,
                            fontFamily: "montserrat",
                            color: Colors.black,
                          ),
                        ),

                    ),
                    // Placeholder to balance row (same width as back btn)
                    SizedBox(width: w * 0.11),
                  ],
                ),

                // ─── Scrollable content ────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: h * 0.07),

                        // ─── Avatar + Camera badge ─────────────────
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Avatar circle with border + glow
                            Container(
                              width: w * 0.335,
                              height: w * 0.335,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF4A90D9)
                                        .withOpacity(0.18),
                                    blurRadius: 30,
                                    spreadRadius: 8,
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: _selectedImage != null
                                    ? Image.file(
                                  _selectedImage!,
                                  fit: BoxFit.cover,
                                  width: w * 0.335,
                                  height: w * 0.335,
                                )
                                    : Container(
                                  color: const Color(0xFF1A1A2E),
                                  child: Image(image: AssetImage("assets/images/profile1.png"),fit: BoxFit.cover,)
                                ),
                              ),
                            ),

                            // Camera badge
                            Positioned(
                              bottom: 6,
                              right: 8,
                              child: GestureDetector(
                                onTap: _pickImage,
                                child: Container(
                                  width: w * 0.08,
                                  height: w * 0.08,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF4A90D9),
                                  ),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: w * 0.055,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: h * 0.06),

                        // ─── Name Field ────────────────────────────
                        _buildTextField(
                          controller: _nameController,
                          hintText: 'Enter name',
                          keyboardType: TextInputType.name,
                          w: w,
                          h: h,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Name is required';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: w * 0.01),

                        // ─── Email Field ───────────────────────────
                        _buildTextField(
                          controller: _emailController,
                          hintText: 'Enter email',
                          keyboardType: TextInputType.emailAddress,
                          w: w,
                          h: h,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email is required';
                            }
                            if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value.trim())) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: h*0.035,),

                          // ✅ BAAD (sahi)
                          ElevatedButton1(text: "Update", onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BottomNavigationScreen(
                                  initialIndex: 3,
                                ),
                              ),
                                  (Route<dynamic> route) => false,
                            );
                          }),

                        SizedBox(height: h * 0.04),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── Reusable TextField ─────────────────────────────────────────
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required double w,
    required double h,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return SizedBox(
      height: h * 0.058,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        style: TextStyle(
          fontSize: w * 0.036,
          fontWeight: FontWeight.w800,
          fontFamily: "poppin",
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: const Color(0xFF9A9A9A),
            fontSize: w * 0.027,
            fontFamily: "poppin",
            fontWeight: FontWeight.w700,
          ),
          filled: true,
          fillColor: const Color(0xFFF7F7F7),
          contentPadding: EdgeInsets.symmetric(
            horizontal: w * 0.04,
            vertical: h * 0.016,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(
              color: Color(0xFFD9D9D9),
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(
              color: Color(0xFFD9D9D9),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(
              color: Color(0xFF4A90D9),
              width: 1.2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}