import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/components/Background/background_add_details_page.dart';
import 'package:frontend/components/Buttons/button3.dart';
import 'package:frontend/components/formfield.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/models/UserModel.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

  Future<void> updateProfile(String full_name,String phone_number,String university_roll)async{
    try {
      UserModel user = await storage.read(key:"user").then((value)=>UserModel.fromJson(jsonDecode(value!)));
      user.fullName = full_name;
      user.phone = phone_number;
      user.universityRoll = university_roll;
      user.status = user.userType == "ALUMNI" ? "EDUCATION_DETAILS":"PROFILE_DETAILS";
      debugPrint(jsonEncode(user));
      await storage.write(key: "user", value: jsonEncode(user));
      await authService.updateUserProfile(user);
    } catch (e) {
      debugPrint(e.toString());
    }
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
                      "Hello Name",
                      style: kRegisterHeading,
                    ),
                    Text(
                      "Please fill in the rest of your details",
                      style: kRegisterSubHeading,
                    ),
                    SizedBox(
                      height: 65.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: MyTextField(
                        label: "Full Name",
                        onSaved: (value) {
                          setState(() {
                            full_name = value;
                          });
                        },
                      ),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: MyTextField(
                        label: "Phone Number",
                        onSaved: (value) {
                          setState(() {
                            phone_number = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: MyTextField(
                        label: "University Roll(you cannot change this later)",
                        onSaved: (value) {
                          setState(() {
                            university_roll = value;
                          });
                        },
                      ),
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
                    SizedBox(
                      height: 10.0,
                    ),
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
        )
      ],
    );
  }
}
