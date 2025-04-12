import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'home.dart';
import 'setting.dart';
import 'profile.dart';
import 'medications_page.dart';
import 'AccountSettingsPage.dart';
import 'NotificationsPage.dart';
import 'PrivacySettingsPage.dart';
import 'LanguageSettingsPage.dart';
import 'AboutPage.dart';
import 'forgot_password_screen.dart'; // Add this line

void main() {
  runApp(const MediMindApp());
}

class MediMindApp extends StatelessWidget {
  const MediMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediMind',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Helvetica',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => HomePage(),
        '/settings': (context) => SettingsPage(),
        '/medications': (context) => MedicationsPage(),
        '/profile': (context) => ProfilePage(),
        '/account': (context) => AccountSettingsPage(),
        '/notifications': (context) => NotificationsPage(),
        '/privacy': (context) => PrivacySettingsPage(),
        '/language': (context) => LanguageSettingsPage(),
        '/about': (context) => AboutPage(),
        '/forgot-password': (context) => ForgotPasswordScreen(), // Add this line
      },
    );
  }
}
