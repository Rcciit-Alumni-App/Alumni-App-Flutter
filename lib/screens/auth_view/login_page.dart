import 'package:flutter/material.dart';
import 'package:frontend/screens/auth_view/signup_page.dart';
import 'package:frontend/screens/auth_view/verification_screen.dart';
import 'package:frontend/services/navigation_service.dart';
import '../../components/background.dart';
import '../../components/button.dart';
import '../../components/formfield.dart'; // If using SvgPicture for SVGs

class LoginPage extends StatefulWidget {

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween<double>(begin: 0.0, end: 1).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    NavigationService navigation = NavigationService();

    return Stack(
      children: [
        BackgroundDesign(), // Assume this is a wavy background widget
        Scaffold(
          backgroundColor: Colors.transparent,
          body: FadeTransition(
            opacity: _animation,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.345,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.sizeOf(context).width * 0.15),
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const MyTextField(label: 'Email'),
                  SizedBox(height: MediaQuery.sizeOf(context).width * 0.12),
                  const MyTextField(label: 'Password'),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.sizeOf(context).width * 0.03),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  Center(
                    child: CustomButton(
                      label: 'Login',
                      onPressed: () {
                        // HANDLE LOGIN PROCESS HERE
                        Navigator.of(context).pushReplacement(navigation.createRoute(route: VerificationPage(verificationTypeText: 'Phone', userType: 'Login',)));
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: MediaQuery.sizeOf(context).width * 0.12),
                    child: Row(
                      children: [
                        Text(
                          'New Here? ',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(navigation.createRoute(route: SignUpPage()));
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
