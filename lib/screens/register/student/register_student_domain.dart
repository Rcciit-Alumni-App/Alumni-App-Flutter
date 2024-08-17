import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/components/Background/background_add_details_page.dart';
import 'package:frontend/components/Buttons/button2.dart';
import 'package:frontend/components/Buttons/button4.dart';
import 'package:frontend/components/socials.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/models/UserModel.dart';
import 'package:frontend/services/alert_services.dart';
import 'package:frontend/services/auth_service.dart';

class RegisterStudentDomain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterStudentDomainState();
  }
}

class _RegisterStudentDomainState extends State<RegisterStudentDomain> {
  final AlertService alertService = AlertService();
  final AuthService authService = AuthService();
  final storage = new FlutterSecureStorage();

  
  List<Socials> socialsList = List.empty(growable: true);

  Socials social = Socials(
    label: 'Domain of Interest',
    hintText: 'Domain',  
  );

  @override
  void initState() {
    super.initState();
    onAddSocials();
  }

  @override
  Widget build(BuildContext context) {

    Future<void> updateProfile() async {
      try {
        UserModel user = await storage.read(key: "user").then((value)=>UserModel.fromJson(jsonDecode(value!)));
        //user.domain = domainList.map((e) => e.text ?? "").toList();
        //user.socials = socialsList.map((e) => e.text ?? "").toList();

        await storage.write(key: "user", value: jsonEncode(user));


        // HANDLE API CALLS HERE //
        await authService.updateUserProfile(user);
        alertService.showSnackBar(message: "Profile created successfully",
            color: Theme.of(context).colorScheme.secondary);

        Navigator.pushNamed(context, '/home');

      } catch (e) {
        debugPrint(e.toString());
      }
    }

    return Stack(children: [
      BackgroundAddDetailsPage(),
      Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton2(
                  label: "Skip",
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                ),
                SizedBox(
                  width: 25.0,
                ),
                CustomButton4(
                  label: "Next",
                  onPressed: () {
                    updateProfile();
                  },
                ),
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 70.0, left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Registered as Student",
                  style: kRegisterHeading,
                ),
                Text(
                  "Please set your profile",
                  style: kRegisterSubHeading,
                ),
                SizedBox(
                  height: 100.0,
                ),
                
                Expanded(
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          // Higher Studies List
                          // ListView.builder(
                          //   shrinkWrap: true,
                          //   physics: NeverScrollableScrollPhysics(), // Disable scrolling
                          //   itemCount: domainList.length,
                          //   itemBuilder: (_, index) {
                          //     return Padding(
                          //       padding: const EdgeInsets.symmetric(vertical: 10.0),
                          //       child: domainList[index],
                          //     );
                          //   },
                          // ),

                          // Align(
                          //   alignment: Alignment.centerRight,
                          //   child: CustomButton2(
                          //     height: 35,
                          //     width: 100,
                          //     label: "Add more",
                          //     onPressed: () {
                          //       onAddDomain();
                          //     },
                          //   ),
                          // ),

                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: social,  
                          ),

                          // Socials List
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(), // Disable scrolling
                            itemCount: socialsList.length,
                            itemBuilder: (_, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: socialsList[index],
                              );
                            },
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: CustomButton2(
                              height: 35,
                              width: 100,
                              label: "Add more",
                              onPressed: () {
                                onAddSocials();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          )),
    ]);
  }

  // onAddDomain() {
  //     setState(() {
  //     domainList.add(
  //       Socials(
  //         label: 'Domain of Interest',
  //         hintText: 'Domain',  
  //       )
  //     );
  //   });
  // }

  onAddSocials() {
    setState(() {
      socialsList.add(
        Socials(
          label: 'Social',
          hintText: 'Link',  
        )
      );
    });
  }
}
