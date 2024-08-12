import 'package:flutter/material.dart';
import 'package:frontend/components/Background/background_add_details_page.dart';
import 'package:frontend/components/Buttons/button4.dart';
import 'package:frontend/components/formfield.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/screens/register/alumni/register_alumni_work.dart';

class RegisterProfileAlumni extends StatefulWidget {
  const RegisterProfileAlumni({super.key});

  @override
  State<RegisterProfileAlumni> createState() => _RegisterProfileAlumniState();
}

class _RegisterProfileAlumniState extends State<RegisterProfileAlumni> {
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
                  "Registered as Alumni",
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
                SizedBox(
                  height: 40.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: MyTextField(
                    enabled: false,
                    label: "Full Name",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: MyTextField(
                    enabled: false,
                    label: "Year of Passout",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: MyTextField(
                    enabled: false,
                    label: "Department",
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: CustomButton4(
                    label: "Next",
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return RegisterAlumniWork();
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
