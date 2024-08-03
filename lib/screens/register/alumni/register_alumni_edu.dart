import 'package:flutter/material.dart';
import 'package:frontend/components/background_add_details_page.dart';
import 'package:frontend/components/button.dart';
import 'package:frontend/components/button2.dart';
import 'package:frontend/components/edu_history.dart';
import 'package:frontend/components/socials.dart';
import 'package:frontend/constants/constants.dart';

class RegisterAlumniEdu extends StatefulWidget {
  const RegisterAlumniEdu({super.key});

  @override
  State<RegisterAlumniEdu> createState() => _RegisterAlumniEduState();
}

class _RegisterAlumniEduState extends State<RegisterAlumniEdu> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundAddDetailsPage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.only(top: 70.0, left: 15.0, right: 23.0),
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
                EduHist(
                  label: "Higher Studies(if any)",
                ),
                SizedBox(
                  height: 10.0,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CustomButton2(
                    height: 35,
                    label: "Add more",
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Socials(
                  label: "Socials(if any)",
                  hintText: "Link",
                ),
                SizedBox(
                  height: 10.0,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CustomButton2(
                    height: 35,
                    label: "Add more",
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton2(
                        label: "Skip",
                        onPressed: () {},
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      CustomButton(
                        label: "Next",
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
