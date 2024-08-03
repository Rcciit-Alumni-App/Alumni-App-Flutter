import 'package:flutter/material.dart';
import 'package:frontend/components/background_add_details_page.dart';
import 'package:frontend/components/button.dart';
import 'package:frontend/components/button2.dart';
import 'package:frontend/components/socials.dart';
import 'package:frontend/constants/constants.dart';

class RegisterStudentDomain extends StatefulWidget {
  const RegisterStudentDomain({super.key});

  @override
  State<RegisterStudentDomain> createState() => _RegisterStudentDomainState();
}

class _RegisterStudentDomainState extends State<RegisterStudentDomain> {
  List<Widget> domain = [
    Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Socials(
        label: "Domain of Interest",
        hintText: "Enter one or more",
      ),
    ),
  ];

  List<Widget> socials = [
    Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Socials(
        label: "Socials(if any)",
        hintText: "Link",
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
                Expanded(
                  child: ListView(
                    children: domain,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CustomButton2(
                    height: 35,
                    label: "Add more",
                    onPressed: () {
                      // setState(() {
                      //   domain.add(Padding(
                      //     padding: const EdgeInsets.only(bottom: 20.0),
                      //     child: Socials(
                      //       hintText: "Enter one and more",
                      //     ),
                      //   ));
                      // });
                    },
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Expanded(
                  child: ListView(
                    children: socials,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CustomButton2(
                    height: 35,
                    label: "Add more",
                    onPressed: () {
                      // setState(() {
                      //   domain.add(Padding(
                      //     padding: const EdgeInsets.only(bottom: 20.0),
                      //     child: Socials(
                      //       hintText: "Link",
                      //     ),
                      //   ));
                      // });
                    },
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Align(
                  alignment: Alignment.center,
                  child: CustomButton(
                    label: "Next",
                    onPressed: () {},
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
