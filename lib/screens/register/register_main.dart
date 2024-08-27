import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/components/Background/background_add_details_page.dart';
import 'package:frontend/components/Buttons/button3.dart';
import 'package:frontend/components/formfield.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/models/UserModel.dart';
import 'package:frontend/screens/register/alumni/register_profile_alumni.dart';
import 'package:frontend/screens/register/student/register_profile_student.dart';
import 'package:frontend/services/alert_services.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/services/loader_service.dart';
import 'package:get_it/get_it.dart';

class RegisterMain extends StatefulWidget {
  const RegisterMain({super.key});

  @override
  State<RegisterMain> createState() => _RegisterMainState();
}

class _RegisterMainState extends State<RegisterMain> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? full_name, phone_number, university_roll;
  final storage = new FlutterSecureStorage();
  final AuthService authService = AuthService();
  late LoaderService _loaderService;
  late AlertService _alertService;

  // GET CALL IN INITSTATE
  Future<void> getUserProfile() async {
    try {
      _loaderService.showLoader();
      
      UserModel? user = await authService.getUserProfile();
      await storage.write(key: "user", value: jsonEncode(user));

      _loaderService.hideLoader();

      _alertService.showSnackBar(
        message: "Login Successful",
        color: Theme.of(context).colorScheme.secondary,
      );
    } catch (e) {
      _loaderService.hideLoader();
      debugPrint(e.toString());
    }
  }

  Future<void> updateProfile(String full_name, String phone_number, String university_roll)async{
    try {
      _loaderService.showLoader();
      UserModel user = await storage.read(key:"user").then((value)=>UserModel.fromJson(jsonDecode(value!)));
      user.fullName = full_name;
      user.phone = phone_number;
      user.universityRoll = university_roll;
      user.status = user.userType == "ALUMNI" ? "EDUCATION_DETAILS":"PROFILE_DETAILS";
      debugPrint(jsonEncode(user));
      await storage.write(key: "user", value: jsonEncode(user));
      await authService.updateUserProfile(user);

      _loaderService.hideLoader();

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return user.userType == 'ALUMNI' ? RegisterProfileAlumni() : RegisterProfileStudent();
      }));

    } catch (e) {
      _loaderService.hideLoader();
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _loaderService = GetIt.instance.get<LoaderService>();
    _alertService = GetIt.instance.get<AlertService>();
    getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundAddDetailsPage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 70.0, left: 20.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello User!",
                      style: kRegisterHeading,
                    ),
                    Text(
                      "Please fill in the rest of your details",
                      style: kRegisterSubHeading,
                    ),
                    SizedBox(
                      height: 100.0,
                    ),
                    MyTextField(
                      label: "Full Name",
                      onSaved: (value) {
                        setState(() {
                          full_name = value;
                        });
                      },
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 20.0),
                    //   child: MyTextField(
                    //     label: "Email",
                    //     onSaved: (value) {
                    //       setState(() {
                    //         email = value;
                    //       });
                    //     },
                    //   ),
                    // ),
                    SizedBox(height: MediaQuery.sizeOf(context).width * 0.05,),
                    MyTextField(
                      label: "Phone Number",
                      onSaved: (value) {
                        setState(() {
                          phone_number = value;
                        });
                      },
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).width * 0.05,),
                    MyTextField(
                      label: "University Roll(you cannot change this later)",
                      onSaved: (value) {
                        setState(() {
                          university_roll = value;
                        });
                      },
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 20.0),
                    //   child: MyTextField(
                    //     label: "College Roll",
                    //     onSaved: (value) {
                    //       setState(() {
                    //         college_roll = value;
                    //       });
                    //     },
                    //   ),
                    // ),
                   SizedBox(height: MediaQuery.sizeOf(context).width * 0.05,),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CustomButton3(
                        label: "Next",
                        onPressed: () {
                          if(_formKey.currentState?.validate() ?? false){
                            _formKey.currentState?.save();
                            updateProfile(full_name!, phone_number!, university_roll!);
                            // Navigator.pushNamed(context, "/register2");
                          }
                        },
                      ),
                    )
                  ],
                ),
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
  }
}
