import 'package:flutter/material.dart';
import 'package:frontend/screens/auth_view/signup_page.dart';
import 'package:frontend/screens/HomeScreen/home_screen.dart';
import 'package:frontend/screens/auth_view/verification_screen.dart';
import 'package:frontend/screens/auth_view/verification_screen_reset.dart';
import 'package:frontend/services/alert_services.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/navigation_service.dart';
import 'package:frontend/services/loader_service.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import '../../components/Background/background.dart';
import '../../components/Buttons/button.dart';
import '../../components/formfield.dart';
import 'package:frontend/providers/user_provider.dart';

class ForgotPasswordPageEmail extends StatefulWidget {
  const ForgotPasswordPageEmail({super.key});

  @override
  State<ForgotPasswordPageEmail> createState() => _ForgotPasswordPageEmailState();
}

class _ForgotPasswordPageEmailState extends State<ForgotPasswordPageEmail> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  NavigationService navigation = NavigationService();
  late AlertService _alertService;
  final AuthService _authService = AuthService();
  final LoaderService _loaderService = GetIt.instance.get<LoaderService>();
  String? personal_email;

  // Future<void> _login(String personal_email, String password, UserProvider userProvider) async {
  //   try {
  //     _loaderService.showLoader();
  //      await _authService.login(personal_email, password);
  //     //userProvider.setUser(user);
  //     _alertService.showSnackBar(
  //       message: "Login Successful",
  //       color: Theme.of(context).colorScheme.secondary,
  //     );
  //     _loaderService.hideLoader();
  //     Navigator.of(context).pushReplacement(
  //       navigation.createRoute(route: HomePage()),
  //     );
  //   } catch (e) {
  //     _alertService.showSnackBar(
  //       message: "Login Failed: $e",
  //       color: Colors.red,
  //     );
  //     print(e);
  //   } finally {
  //     _loaderService.hideLoader();
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _alertService = GetIt.instance.get<AlertService>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return Stack(
          children: [
            BackgroundDesign(), // Assume this is a wavy background widget
            Scaffold(
              backgroundColor: Colors.transparent,
              body: Padding(
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
                              'Reset Password',
                              style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      MyTextField(
                        label: 'Enter your Personal Email',
                        onSaved: (v) {
                          setState(() {
                            personal_email = v;
                          });
                        },
                      ),
                      
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(context, MaterialPageRoute(builder: (context) {
                      //       return ForgotPasswordPage();
                      //     }));
                      //   },
                      //   child: Padding(
                      //     padding: EdgeInsets.symmetric(
                      //         vertical: MediaQuery.sizeOf(context).width * 0.03),
                      //     child: Text(
                      //       'Forgot Password?',
                      //       style: TextStyle(
                      //           fontWeight: FontWeight.bold,
                      //           color: Theme.of(context).colorScheme.primary),
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                               vertical: MediaQuery.sizeOf(context).width * 0.03),
                        child: Center(
                          child: CustomButton(
                            label: 'Next',
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                _formKey.currentState?.save();
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return VerificationPageReset(verificationTypeText: 'Email', userType: 'Reset Password');
                                }));
                              }
                            },
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //       top: MediaQuery.sizeOf(context).width * 0.12),
                      //   child: Row(
                      //     children: [
                      //       Text(
                      //         'New Here? ',
                      //         style: TextStyle(
                      //             color: Theme.of(context).colorScheme.primary),
                      //       ),
                      //       GestureDetector(
                      //         onTap: () {
                      //           Navigator.of(context).pushReplacement(
                      //               navigation.createRoute(route: SignUpPage()));
                      //         },
                      //         child: Text(
                      //           'Sign Up',
                      //           style: TextStyle(
                      //             color: Theme.of(context).colorScheme.primary,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder<bool>(
              stream: _loaderService.loadingStream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!) {
                  return Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ],
        );
      },
    );
  }
}
