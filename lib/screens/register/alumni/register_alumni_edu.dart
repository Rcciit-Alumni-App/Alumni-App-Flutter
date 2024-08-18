import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/components/Background/background_add_details_page.dart';
import 'package:frontend/components/Buttons/button2.dart';
import 'package:frontend/components/Buttons/button4.dart';
import 'package:frontend/components/edu_history.dart';
import 'package:frontend/components/Socials/socials.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/models/UserModel.dart';
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

  // Higher Studies List
  List<HigherStudiesFormWidget> higherStudiesForms = List.empty(growable: true);
  int nextAvailableIdStudy = 0;

  // Socials List
  int nextAvailableIdSocial = 0;
  List<Socials?> socialsList = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    onAddHigherStudies();
    onAddSocials();
  }

  @override
  Widget build(BuildContext context) {

    bool validateForms() {
      bool allValid = true;

      higherStudiesForms
        .forEach((element) => allValid = (allValid && element.isValidated()));

      socialsList
        .forEach((element) {
          if (element != null) {
            allValid = (allValid && element.isValidated());
          }
      });

      return allValid;
    }

    Future<void> updateProfile() async {
      try {
        UserModel user = await storage.read(key: "user").then((value)=>UserModel.fromJson(jsonDecode(value!)));
        
        bool isValid = validateForms();

        if (!isValid) return;

        user.higherStudies = higherStudiesForms
          .map((e) => e.higherStudiesModel)
          .toList();

        user.higherStudies = higherStudiesForms
          .asMap().entries.map((e) {
          int index = e.key;
          HigherStudiesFormWidget element = e.value;
          element.higherStudiesModel.id = index + 1;
          return element.higherStudiesModel;
        }).toList();

        List<SocialLink> list = [];
        int id = 0;

        for (Socials? element in socialsList) {
          if (element != null) {
            element.socialLinkModel.id = id++;
            list.add(element.socialLinkModel);
          }
        }

        user.socials = list;

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
                                onAddHigherStudies();
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
                                padding: const EdgeInsets.symmetric(vertical: 0.0),
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
  onRemoveHigherStudies(HigherStudy higherStudiesModel) {

    if (higherStudiesForms.length == 1) {
      return null;
    }

    setState(() {
      int index = higherStudiesForms
          .indexWhere((element) => element.higherStudiesModel.id == higherStudiesModel.id);

      higherStudiesForms.removeAt(index);
    });
  }

  onAddHigherStudies() {
    setState(() {
      HigherStudy _higherStudiesModel = HigherStudy(id: nextAvailableIdStudy);
      higherStudiesForms.add(HigherStudiesFormWidget(
        index: higherStudiesForms.length,
        higherStudiesModel: _higherStudiesModel,
        onRemove: () => onRemoveHigherStudies(_higherStudiesModel),
      ));
    });
  }

  onAddSocials() {
    setState(() {
      SocialLink _socialLink = SocialLink(id: nextAvailableIdSocial);
      nextAvailableIdSocial++;
      
      socialsList.add(
        Socials(
          socialLinkModel: _socialLink,
          label: 'Social',
          hintText: 'Link',
          onRemove: () => onRemoveSocials(_socialLink),
        )
      );
    });
  }

  onRemoveSocials(SocialLink socialLink) {
    int notNullElements = 0;

    for (Socials? element in socialsList) {
      if (element != null) {
        notNullElements++;
      }
    }

    if (notNullElements == 1) {
      return null;
    }

    setState(() {
      int index = socialsList
          .indexWhere((element) {
            if (element != null) 
              return element.socialLinkModel.id == socialLink.id;
            return false;
          });

      // if (socialsList != null) socialsList.removeAt(index);
      if (socialsList != null) socialsList[index] = null;
    });
  }
}
