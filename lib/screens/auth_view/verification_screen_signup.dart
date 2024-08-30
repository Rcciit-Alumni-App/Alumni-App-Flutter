import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/components/Background/background_verification_page.dart';
import 'package:frontend/components/FormFields/formfield.dart';
import 'package:frontend/models/UserModel.dart';
import 'package:frontend/screens/DigitalID/digital_id.dart';
import 'package:frontend/screens/register/register_main.dart';
import 'package:frontend/services/alert_services.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/loader_service.dart';
import 'package:get_it/get_it.dart';
import '../../components/Buttons/button.dart';
import '../../services/navigation_service.dart';

class VerificationPage extends StatefulWidget {
  final void Function()? onTap;
  final String userType;

  const VerificationPage({super.key, required this.userType, this.onTap});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final NavigationService navigation = NavigationService();
  late AlertService _alertService;
  late LoaderService _loaderService;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final storage = new FlutterSecureStorage();
  String? otp;


  Timer? _timer;
  int _start = 10;
  bool _isButtonDisabled = false;


  Future<void> verify(String otp) async {
    try {
      _loaderService.showLoader();
      await authService.verify(otp);

      _loaderService.hideLoader();

      _alertService.showSnackBar(
          message: "Verification Successful",
          color: Theme.of(context).colorScheme.secondary);
      print("Verification Successful");
      Navigator.of(context).pushReplacement(navigation.createRoute(route: RegisterMain()));
    } catch (e) {
      _loaderService.hideLoader();
      debugPrint("Error "+e.toString());
    }
  }


  @override
  void initState() {
    super.initState();
    _alertService = GetIt.instance.get<AlertService>();
    _loaderService = GetIt.instance.get<LoaderService>();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween<double>(begin: 0.0, end: 1).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
    ));
    _controller.forward();

    _startTimer();
  }

  @override
  void dispose() {
     _timer?.cancel();

    _controller.dispose();
    super.dispose();
  }


  void _startTimer() {
    _isButtonDisabled = true;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            _isButtonDisabled = false;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void _sendOTP() async {
    try {
      _loaderService.showLoader();
      String? token = await storage.read(key: "verificationToken");
      
      if (token != null) {
        await authService.sendOtp(token);
      }
      
      _loaderService.hideLoader();

      _alertService.showSnackBar(
          message: "OTP sent Successfully.",
          color: Theme.of(context).colorScheme.secondary);

      setState(() {
        _start = 10;
      });
      _startTimer();

    } catch (e) {
      _loaderService.hideLoader();
      debugPrint("Error "+e.toString());
    }
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
              child: SingleChildScrollView(
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
                          'Please enter the OTP we have sent to\nyour email',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: MediaQuery.sizeOf(context).width * 0.1),
                        child: MyTextField(label: 'Enter OTP',
                        onSaved: (value){
                          setState(() {
                            otp = value;
                          });
                        }
                        ,),
                      ),
                
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.sizeOf(context).width * 0.015),
                          child: GestureDetector(
                            onTap: _isButtonDisabled ? null : _sendOTP,
                            child: Text(
                              _start != 0 ? 'Resend OTP in: $_start seconds' : 'Resend OTP',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding:
                      //       EdgeInsets.only(top: MediaQuery.sizeOf(context).width * 0.1),
                      //   child: GestureDetector(
                      //     onTap: () {
                  
                      //       Navigator.of(context).pushReplacement(navigation.createRoute(route: VerificationPage(verificationTypeText: widget.verificationTypeText == 'Email' ? 'Phone' : 'Email', userType: widget.userType)));
                  
                      //     },
                      //     child: Text(
                      //       widget.verificationTypeText == 'Email' ? 'Use phone number instead' : 'Use email instead',
                      //       style: TextStyle(
                      //           color: Theme.of(context).colorScheme.primary),
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: MediaQuery.sizeOf(context).width * 0.12),
                        child: Center(
                            child: CustomButton(width: 140, label: widget.userType, onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                _formKey.currentState?.save();
                                debugPrint(otp!);
                                verify(otp!);
                              }
                            })),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
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
    ]);
  }
}
