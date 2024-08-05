import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/screens/auth_view/signup_page.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/services/alert_services.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/navigation_service.dart';
import 'package:get_it/get_it.dart';
import '../../components/Background/background.dart';
import '../../components/Buttons/button.dart';
import '../../components/formfield.dart'; // If using SvgPicture for SVGs

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  NavigationService navigation = NavigationService();
  late AnimationController _controller;
  late Animation<double> _animation;
  late AlertService _alertService;
  final AuthService _authService = AuthService();
  String? personal_email, password;
  Future<void> _login(String personal_email, String password) async {
    try {
    await _authService.login(personal_email, password);
    _alertService.showSnackBar(message: "Login Successful",color: Theme.of(context).colorScheme.secondary);
    Navigator.of(context).pushReplacement(navigation.createRoute(route: HomePage()));
    } catch (e) {
      print(e);
    }
  }

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
              child: Form(
                key: _formKey,
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
                    MyTextField(
                      label: 'Personal Email',
                      onSaved: (v) {
                        setState(() {
                          personal_email = v;
                        });
                      },
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).width * 0.12),
                    MyTextField(
                      label: 'Password',
                      onSaved: (v) {
                        setState(() {
                          password = v;
                        });
                      },
                    ),
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
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
                             debugPrint(personal_email);
                            _login(personal_email!, password!);
                          
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.sizeOf(context).width * 0.12),
                      child: Row(
                        children: [
                          Text(
                            'New Here? ',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  navigation.createRoute(route: SignUpPage()));
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
        ),
      ],
    );
  }
}
