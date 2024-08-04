// import 'package:flutter/material.dart';
// import 'package:frontend/components/background_add_details_page.dart';
// import 'package:frontend/components/button.dart';
// import 'package:frontend/components/button2.dart';
// import 'package:frontend/components/work_exp.dart';
// import 'package:frontend/constants/constants.dart';

// class RegisterStudentIntern extends StatefulWidget {
  
//   @override
//   State<RegisterStudentIntern> createState() => _RegisterStudentInternState();
// }

// class _RegisterStudentInternState extends State<RegisterStudentIntern> {
//   List<Widget> arr = [
//     Padding(
//       padding: const EdgeInsets.only(bottom: 20.0),
//       child: WorkExp(
//         label: "Internship Experience(if any)",
//       ),
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         BackgroundAddDetailsPage(),
//         Scaffold(
//           backgroundColor: Colors.transparent,
//           body: Padding(
//             padding: const EdgeInsets.only(top: 70.0, left: 15.0, right: 23.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Registered as Student",
//                   style: kRegisterHeading,
//                 ),
//                 Text(
//                   "Please set your profile",
//                   style: kRegisterSubHeading,
//                 ),
//                 SizedBox(
//                   height: 100.0,
//                 ),
//                 Expanded(
//                   child: ListView(
//                     children: arr,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15.0,
//                 ),
//                 Align(
//                   alignment: Alignment.bottomRight,
//                   child: CustomButton2(
//                     height: 35,
//                     label: "Add more",
//                     onPressed: () {
//                        setState(() {
//                         arr.add(Padding(
//                           padding: const EdgeInsets.only(bottom: 20.0),
//                           child: WorkExp(),
//                         ));
//                       });
//                     },
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20.0,
//                 ),
//                 Align(
//                   alignment: Alignment.center,
//                   child: Padding(
//                     padding: const EdgeInsets.only(bottom: 10.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CustomButton2(
//                           label: "Skip",
//                           onPressed: () {},
//                         ),
//                         SizedBox(
//                           width: 10.0,
//                         ),
//                         CustomButton(
//                           label: "Next",
//                           onPressed: () {},
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:frontend/components/background_add_details_page.dart';
import 'package:frontend/components/button.dart';
import 'package:frontend/components/button2.dart';
import 'package:frontend/components/button4.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/components/work_exp.dart';
import 'package:frontend/models/work_experience_model.dart';

class RegisterStudentWork extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterStudentWorkState();
  }
}

class _RegisterStudentWorkState extends State<RegisterStudentWork> {
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
                Text(
                  'Internship Experience (If any)',
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
