import 'package:flutter/material.dart';
import 'package:frontend/components/background_verification_page.dart';
import '../../components/button.dart';
import '../../components/formfield.dart';
import '../../services/navigation_service.dart';

class VerificationPage extends StatefulWidget {
  final String verificationTypeText;
  final void Function()? onTap;
  final String userType;

  const VerificationPage({super.key, required this.verificationTypeText, required this.userType, this.onTap});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage>
    with SingleTickerProviderStateMixin {
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

    return Stack(children: [
      VerificationBackgroundDesign(),
      Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.06),
            child: FadeTransition(
              opacity: _animation,
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
                          widget.userType,
                          style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: MediaQuery.sizeOf(context).width * 0.1),
                    child: Text(
                      'Please enter the OTP we have sent to\nyour ${widget.verificationTypeText.toLowerCase()}',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: MediaQuery.sizeOf(context).width * 0.1),
                    child: const MyTextField(label: 'Enter OTP'),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.sizeOf(context).width * 0.015),
                      child: GestureDetector(
                        onTap: () {
                          // Implement resend OTP functionality
                        },
                        child: Text(
                          'Resend OTP',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: MediaQuery.sizeOf(context).width * 0.1),
                    child: GestureDetector(
                      onTap: () {

                        Navigator.of(context).pushReplacement(navigation.createRoute(route: VerificationPage(verificationTypeText: widget.verificationTypeText == 'Email' ? 'Phone' : 'Email', userType: widget.userType)));

                      },
                      child: Text(
                        widget.verificationTypeText == 'Email' ? 'Use phone number instead' : 'Use email instead',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: MediaQuery.sizeOf(context).width * 0.12),
                    child: Center(
                        child: CustomButton(label: widget.userType, onPressed: () {})),
                  ),
                ],
              ),
            ),
          )),
    ]);
  }
}
