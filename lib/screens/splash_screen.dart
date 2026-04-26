import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF2563EB).withOpacity(0.1),
              ),
              child: const Icon(
                Icons.swap_horizontal_circle,
                size: 100,
                color: Color(0xFF3B82F6),
              ),
            ).animate().fadeIn(duration: 600.ms).scale(delay: 200.ms).shimmer(delay: 1.seconds),
            
            const SizedBox(height: 24),
            
            Text(
              'Skill Swap',
              style: GoogleFonts.outfit(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),
            
            const SizedBox(height: 8),
            
            Text(
              'Connect • Learn • Grow',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: Colors.white54,
                letterSpacing: 1.5,
              ),
            ).animate().fadeIn(delay: 600.ms),
            
            const SizedBox(height: 60),
            
            const CircularProgressIndicator(
              color: Color(0xFF3B82F6),
              strokeWidth: 2,
            ).animate().fadeIn(delay: 800.ms),
          ],
        ),
      ),
    );
  }
}
