import 'package:flutter/material.dart';
import 'package:frontend/components/Background/background_add_details_page.dart';
import 'package:frontend/components/Buttons/button4.dart';
import 'package:frontend/components/formfield.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/screens/register/student/register_student_work.dart';

class RegisterProfileStudent extends StatefulWidget {
  const RegisterProfileStudent({super.key});

  @override
  State<RegisterProfileStudent> createState() => _RegisterProfileStudentState();
}

class _RegisterProfileStudentState extends State<RegisterProfileStudent> {

  @override
  void initState() {
    super.initState();

    // FETCH DATA FROM LOCAL AND JUST DISPLAY

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundAddDetailsPage(),
        Scaffold(
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
                  height: 20.0,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage: AssetImage("assets/default-user.jpg"),
                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).width * 0.05),
                MyTextField(
                  enabled: false,
                  label: "Full Name",
                ),
                SizedBox(height: MediaQuery.sizeOf(context).width * 0.05),
                MyTextField(
                  enabled: false,
                  label: "Current year of study",
                ),
                SizedBox(height: MediaQuery.sizeOf(context).width * 0.05),
                MyTextField(
                  enabled: false,
                  label: "Year of Passout",
                ),
                SizedBox(height: MediaQuery.sizeOf(context).width * 0.05),
                MyTextField(
                  enabled: false,
                  label: "Department",
                ),
                SizedBox(height: MediaQuery.sizeOf(context).width * 0.05),
                Center(
                  child: CustomButton4(
                    label: "Next",
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return RegisterStudentWork();
                      }));
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
