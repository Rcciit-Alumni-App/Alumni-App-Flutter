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




import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/components/Background/background_add_details_page.dart';
import 'package:frontend/components/Buttons/button2.dart';
import 'package:frontend/components/Buttons/button4.dart';
import 'package:frontend/components/internship_exp.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/components/work_exp.dart';
import 'package:frontend/models/UserModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/screens/register/student/register_student_domain.dart';
import 'package:frontend/services/alert_services.dart';

class RegisterStudentWork extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterStudentWorkState();
  }
}

class _RegisterStudentWorkState extends State<RegisterStudentWork> {
  final AlertService alertService = AlertService();
  final storage = new FlutterSecureStorage();

  List<InternshipExperienceFormWidget> internshipExperienceForms = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    onAdd();
  }

  @override
  Widget build(BuildContext context) {

    Future<void> updateProfile() async {
      try {
        UserModel user = await storage.read(key: "user").then((value)=>UserModel.fromJson(jsonDecode(value!)));

        user.internships = internshipExperienceForms
          .map((e) => e.internshipExperience)
          .toList();
        await storage.write(key: "user", value: jsonEncode(user));

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return RegisterStudentDomain();
        }));

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

                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return RegisterStudentDomain();
                    }));

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
                  itemCount: internshipExperienceForms.length,
                  itemBuilder: (_, index) {
                    return internshipExperienceForms[index];
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
  onRemove(Internship internshipExperience) {

    if (internshipExperienceForms.length == 1) {
      return null;
    }

    setState(() {
      int index = internshipExperienceForms
          .indexWhere((element) => element.internshipExperience.id == internshipExperience.id);

      if (internshipExperienceForms != null) internshipExperienceForms.removeAt(index);
    });
  }

  onAdd() {
    setState(() {
      Internship _internshipExperience = Internship(id: internshipExperienceForms.length);
      internshipExperienceForms.add(InternshipExperienceFormWidget(
        index: internshipExperienceForms.length,
        internshipExperience: _internshipExperience,
        onRemove: () => onRemove(_internshipExperience),
      ));
    });
  }
}
