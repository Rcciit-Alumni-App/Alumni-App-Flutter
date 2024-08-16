import 'package:flutter/material.dart';
import 'package:frontend/screens/auth_view/login_page.dart';
import 'package:frontend/screens/auth_view/verification_screen.dart';
import 'package:frontend/services/alert_services.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/loader_service.dart';
import 'package:frontend/services/navigation_service.dart';
import 'package:get_it/get_it.dart';
import '../../components/Background/background.dart';
import '../../components/Buttons/button.dart';
import '../../components/formfield.dart'; // If using SvgPicture for SVGs

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late AlertService _alertService;
  final AuthService authService = AuthService();
  final NavigationService navigation = NavigationService();
  final LoaderService loaderService = LoaderService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? personal_email,
      college_email,
      college_roll,
      password,
      confirmPassword;
  @override
  void initState() {
    super.initState();
    _alertService = GetIt.instance.get<AlertService>();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
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
    // initState() {
    //   super.initState();
    //   authService = GetIt.instance.get<AuthService>();
    // }
    Future<void> signUp(String personal_email, String college_email,
        String college_roll, String password) async {
      try {
        if (password != confirmPassword) {
          debugPrint('Passwords do not match');
          return;
        }
        loaderService.showLoader();
        await authService.signup(
            personal_email, college_email, college_roll, password);
        _alertService.showSnackBar(message: "Otp Sent Successfully",
            color: Theme.of(context).colorScheme.secondary);
            loaderService.hideLoader();
        Navigator.of(context).pushReplacement(navigation.createRoute(route: VerificationPage(verificationTypeText: 'Phone', userType: 'Sign Up')));
      } catch (e) {
        print(e);
      }
    }


    return Stack(
      children: [
        BackgroundDesign(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: FadeTransition(
            opacity: _animation,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.06),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.245,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.sizeOf(context).width * 0.15),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    MyTextField(
                      label: 'Personal Email',
                      onSaved: (value) {
                        setState(() {
                          personal_email = value;
                        });
                      },
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).width * 0.05),
                    MyTextField(
                      label: 'College Email',
                      onSaved: (value) {
                        setState(() {
                          college_email = value;
                        });
                      },
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).width * 0.05),
                    MyTextField(
                      label: 'College Roll',
                      onSaved: (value) {
                        setState(() {
                          college_roll = value;
                        });
                      },
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).width * 0.05),
                    MyTextField(
                      label: 'Password',
                      onSaved: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).width * 0.05),
                    MyTextField(
                      label: 'Confirm Password',
                      onSaved: (value) {
                        setState(() {
                          confirmPassword = value;
                        });
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.sizeOf(context).width * 0.05),
                      child: Row(
                        children: [
                          Text(
                            'Have an account? ',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  navigation.createRoute(route: LoginPage()));
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
                            if (_formKey.currentState?.validate() ?? false) {
                              _formKey.currentState
                                  ?.save(); 
                                
                              signUp(personal_email!, college_email!,
                                  college_roll!, password!);
                            }
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
        ),
      ],
    );
  }
}
