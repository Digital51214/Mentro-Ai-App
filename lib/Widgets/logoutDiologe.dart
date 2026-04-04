import 'package:flutter/material.dart';
import 'package:mentro_ai_app/AuthonticationScreens/LoginScreen.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  /// Call this static method to show the dialog from anywhere
  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true, // tap outside = cancel
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => const LogoutDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double w = size.width;
    final double h = size.height;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: w * 0.07),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          horizontal: w * 0.07,
          vertical: h * 0.035,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Red logout icon circle ─────────────────────────────
            Container(
              width: w * 0.2,
              height: w * 0.2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red.shade50,
                border: Border.all(
                  color: Colors.red.shade100,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.logout_rounded,
                color: Colors.red.shade400,
                size: w * 0.1,
              ),
            ),

            SizedBox(height: h * 0.025),

            // ── Title ──────────────────────────────────────────────
            Text(
              'Logout',
              style: TextStyle(
                fontSize: w * 0.058,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1A1A2E),
                letterSpacing: -0.3,
              ),
            ),

            SizedBox(height: h * 0.012),

            // ── Subtitle ───────────────────────────────────────────
            Text(
              'Are you sure you want to\nlog out of your account?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: w * 0.038,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade500,
                height: 1.5,
              ),
            ),

            SizedBox(height: h * 0.035),

            // ── Buttons Row ────────────────────────────────────────
            Row(
              children: [
                // Cancel button
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: h * 0.062,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 1.2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: w * 0.04),

                // Logout button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SignInScreen()),
                          (Route<dynamic>route)=>false); // close dialog
                      // Navigate to LoginScreen and remove all previous routes
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login', // <-- your login route name
                            (route) => false,
                      );
                    },
                    child: Container(
                      height: h * 0.062,
                      decoration: BoxDecoration(
                        color: Colors.red.shade400,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}