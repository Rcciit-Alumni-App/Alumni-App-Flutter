import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/Background/background_add_details_page.dart';
import 'package:frontend/components/Buttons/button2.dart';
import 'package:frontend/components/Buttons/button4.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/components/work_exp.dart';
import 'package:frontend/models/UserModel.dart';
// import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/services/alert_services.dart';
//import 'package:frontend/services/auth_service.dart';
// import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RegisterAlumniWork extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterAlumniWorkState();
  }
}

class _RegisterAlumniWorkState extends State<RegisterAlumniWork> {
  final AlertService alertService = AlertService();
  final storage = new FlutterSecureStorage();

  List<WorkExperienceFormWidget> workExperienceForms = List.empty(growable: true);
  int nextAvailableIdWork = 0;

  @override
  void initState() {
    super.initState();
    onAdd();
  }

  @override
  Widget build(BuildContext context) {

    bool validateForms() {
      bool allValid = true;

      workExperienceForms
        .forEach((element) => allValid = (allValid && element.isValidated()));

      return allValid;
    }

    Future<void> updateProfile() async {
      try {
        UserModel user = await storage.read(key: "user").then((value)=>UserModel.fromJson(jsonDecode(value!)));

        bool isValid = validateForms();

        if (!isValid) return;

        user.workExperiences = workExperienceForms
          .asMap().entries.map((e) {
          int index = e.key;
          WorkExperienceFormWidget element = e.value;
          element.workExperience.id = index + 1;
          return element.workExperience;
        }).toList();

        await storage.write(key: "user", value: jsonEncode(user));
        Navigator.pushNamed(context, '/alumni-education');
        
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    return Stack(children: [
      BackgroundAddDetailsPage(),
      Scaffold(

          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton2(
                  label: "Skip",
                  onPressed: () {

                    Navigator.pushNamed(context, '/alumni-education');

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

          backgroundColor: Colors.transparent,
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
                  'Work Experience (If any)',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Expanded(
                  child: ListView.builder(
                  itemCount: workExperienceForms.length,
                  itemBuilder: (_, index) {
                    return workExperienceForms[index];
                  })
                ),
                SizedBox(
                  height: 15.0,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CustomButton2(
                    height: 35,
                    label: "Add more",
                    onPressed: () {
                      onAdd();
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                
              ],
            ),
          )),
    ]);
  }

  //Delete specific form
  onRemove(WorkExperience workExperience) {

    if (workExperienceForms.length == 1) {
      return null;
    }

    setState(() {
      int index = workExperienceForms
          .indexWhere((element) => element.workExperience.id == workExperience.id);

      workExperienceForms.removeAt(index);
    });
  }

  onAdd() {
    setState(() {
      WorkExperience _workExperience = WorkExperience(id: nextAvailableIdWork);
      workExperienceForms.add(WorkExperienceFormWidget(
        index: workExperienceForms.length,
        workExperience: _workExperience,
        onRemove: () => onRemove(_workExperience),
      ));
    });
  }
}
