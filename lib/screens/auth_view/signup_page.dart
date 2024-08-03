import 'package:flutter/material.dart';
import 'package:frontend/screens/auth_view/login_page.dart';
import 'package:frontend/screens/auth_view/verification_screen.dart';
import 'package:frontend/services/navigation_service.dart';
import '../../components/background.dart';
import '../../components/button.dart';
import '../../components/formfield.dart'; // If using SvgPicture for SVGs

class SignUpPage extends StatefulWidget {

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with SingleTickerProviderStateMixin {

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
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  const MyTextField(label: 'Full Name'),
                  SizedBox(height: MediaQuery.sizeOf(context).width * 0.05),
                  const MyTextField(label: 'Email'),
                  SizedBox(height: MediaQuery.sizeOf(context).width * 0.05),
                  const MyTextField(label: 'Password'),
                  SizedBox(height: MediaQuery.sizeOf(context).width * 0.05),
                  const MyTextField(label: 'Confirm Password'),

                  Padding(
                    padding:
                        EdgeInsets.only(top: MediaQuery.sizeOf(context).width * 0.05),
                    child: Row(
                      children: [
                        Text(
                          'Have an account? ',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(navigation.createRoute(route: LoginPage()));
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: CustomButton(
                        label: 'Sign Up',
                        onPressed: () {
                          // HANDLE LOGIN PROCESS HERE
                          Navigator.of(context).pushReplacement(navigation.createRoute(route: VerificationPage(verificationTypeText: 'Phone', userType: 'Sign Up')));
                        },
                      ),
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
