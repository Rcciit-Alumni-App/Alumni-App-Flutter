import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/components/Background/background_add_details_page.dart';
import 'package:frontend/components/Buttons/button2.dart';
import 'package:frontend/components/Buttons/button4.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/components/work_exp.dart';
import 'package:frontend/models/work_experience_model.dart';

class RegisterAlumniWork extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterAlumniWorkState();
  }
}

class _RegisterAlumniWorkState extends State<RegisterAlumniWork> {
  List<WorkExperienceFormWidget> contactForms = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    onAdd();
  }

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {},
                ),
                SizedBox(
                  width: 25.0,
                ),
                CustomButton4(
                  label: "Next",
                  onPressed: () {
                    onSave();
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
                  itemCount: contactForms.length,
                  itemBuilder: (_, index) {
                    return contactForms[index];
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

  onSave() {

    // --------------------------------------- HANDLE VALIDATION HERE---------------------------------------------

    List<Map?> data = contactForms
        .map((e) => {
              'name': e.contactModel.name,
              'startDate': e.contactModel.startDate,
              'skills': e.contactModel.skills
            })
        .toList();

    print(data);
  }

  //Delete specific form
  onRemove(WorkExperienceModel contact) {

    if (contactForms.length == 1) {
      return null;
    }

    setState(() {
      int index = contactForms
          .indexWhere((element) => element.contactModel.id == contact.id);

      if (contactForms != null) contactForms.removeAt(index);
    });
  }

  onAdd() {
    setState(() {
      WorkExperienceModel _contactModel = WorkExperienceModel(id: contactForms.length);
      contactForms.add(WorkExperienceFormWidget(
        index: contactForms.length,
        contactModel: _contactModel,
        onRemove: () => onRemove(_contactModel),
      ));
    });
  }
}
