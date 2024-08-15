import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/components/Background/background_add_details_page.dart';
import 'package:frontend/components/Buttons/button2.dart';
import 'package:frontend/components/Buttons/button4.dart';
import 'package:frontend/components/edu_history.dart';
import 'package:frontend/components/socials.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/models/UserModel.dart';
import 'package:frontend/models/higher_studies_model.dart';
import 'package:frontend/services/alert_services.dart';
import 'package:frontend/services/auth_service.dart';

class RegisterAlumniEdu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterAlumniEduState();
  }
}

class _RegisterAlumniEduState extends State<RegisterAlumniEdu> {
  final AlertService alertService = AlertService();
  final AuthService authService = AuthService();
  final storage = new FlutterSecureStorage();

  List<HigherStudiesFormWidget> higherStudiesForms = List.empty(growable: true);
  List<Socials> socialsList = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    onAdd();
    onAddSocials();
  }

  

  @override
  Widget build(BuildContext context) {

    Future<void> updateProfile() async {
      try {
        UserModel user = await storage.read(key: "user").then((value)=>UserModel.fromJson(jsonDecode(value!)));
        
        user.higherStudies = higherStudiesForms
          .map((e) => e.higherStudiesModel)
          .toList();

        user.socials = socialsList.map((e) => e.text ?? "").toList();

        await storage.write(key: "user", value: jsonEncode(user));

        // WRITE API CALLS HERE //
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
                  "Registered as Alumni",
                  style: kRegisterHeading,
                ),
                Text(
                  "Please set your profile",
                  style: kRegisterSubHeading,
                ),
                SizedBox(
                  height: 100.0,
                ),
                Text(
                  'Higher Studies (If any)',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          // Higher Studies List
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(), // Disable scrolling
                            itemCount: higherStudiesForms.length,
                            itemBuilder: (_, index) {
                              return higherStudiesForms[index];
                            },
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: CustomButton2(
                              height: 35,
                              width: 100,
                              label: "Add more",
                              onPressed: () {
                                onAdd();
                              },
                            ),
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
                          const SizedBox(height: 10),
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
                const SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          )),
    ]);
  }

  //Delete specific form
  onRemove(HigherStudy higherStudiesModel) {

    if (higherStudiesForms.length == 1) {
      return null;
    }

    setState(() {
      int index = higherStudiesForms
          .indexWhere((element) => element.higherStudiesModel.id == higherStudiesModel.id);

      if (higherStudiesForms != null) higherStudiesForms.removeAt(index);
    });
  }

  onAdd() {
    setState(() {
      HigherStudy _higherStudiesModel = HigherStudy(id: higherStudiesForms.length);
      higherStudiesForms.add(HigherStudiesFormWidget(
        index: higherStudiesForms.length,
        higherStudiesModel: _higherStudiesModel,
        onRemove: () => onRemove(_higherStudiesModel),
      ));
    });
  }

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
