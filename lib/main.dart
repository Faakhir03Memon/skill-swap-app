import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Ensure Firebase configuration is provided via flutterfire configure before running
  // await Firebase.initializeApp();
  runApp(const SkillSwapApp());
}

class SkillSwapApp extends StatelessWidget {
  const SkillSwapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skill Swap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A), // Royal Blue
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      home: const SplashScreen(),
    );
  }
}
