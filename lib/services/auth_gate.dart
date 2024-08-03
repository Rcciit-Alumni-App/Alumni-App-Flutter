import 'package:flutter/material.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/auth_view/login_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});
  final bool _auth = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _auth != false ? HomePage() : LoginPage()
    );
  }
}
