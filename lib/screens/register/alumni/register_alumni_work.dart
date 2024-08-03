import 'package:flutter/material.dart';
import 'package:frontend/components/background_add_details_page.dart';
import 'package:frontend/components/button.dart';
import 'package:frontend/components/button2.dart';
import 'package:frontend/components/work_exp.dart';
import 'package:frontend/constants/constants.dart';

class RegisterAlumniWork extends StatefulWidget {
  const RegisterAlumniWork({super.key});

  @override
  State<RegisterAlumniWork> createState() => _RegisterAlumniWorkState();
}

class _RegisterAlumniWorkState extends State<RegisterAlumniWork> {
  List<Widget> arr = [
    Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: WorkExp(
        label: "Work Experience(if any)",
      ),
    ),
  ];

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
                Expanded(
                  child: ListView(
                    children: arr,
                  ),
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
                      setState(() {
                        arr.add(Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: WorkExp(),
                        ));
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
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
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
