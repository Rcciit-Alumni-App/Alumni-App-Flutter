import 'package:flutter/material.dart';
import 'package:frontend/screens/auth_view/forgot_password_page_email.dart';
import 'package:frontend/screens/auth_view/signup_page.dart';
import 'package:frontend/screens/HomeScreen/home_screen.dart';
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

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  NavigationService navigation = NavigationService();
  late AlertService _alertService;
  final AuthService _authService = AuthService();
  final LoaderService _loaderService = GetIt.instance.get<LoaderService>();
  String? new_password, confirm_password;


  _resetPassword(String newPassword, String confirmPassword, UserProvider userProvider) {

  }

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
                        label: 'New Password',
                        onSaved: (v) {
                          setState(() {
                            new_password = v;
                          });
                        },
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).width * 0.12),
                      MyTextField(
                        label: 'Confirm Password',
                        onSaved: (v) {
                          setState(() {
                            confirm_password = v;
                          });
                        },
                      ),
                      
                      SizedBox(height: 20,),

                      Center(
                        child: CustomButton(
                          label: 'Login',
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              _formKey.currentState?.save();
                              
                              _resetPassword(new_password!, confirm_password!, userProvider);
                            }
                          },
                        ),
                      ),
                      
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
