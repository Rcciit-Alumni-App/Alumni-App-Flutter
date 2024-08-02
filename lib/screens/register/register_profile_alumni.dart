import 'package:flutter/material.dart';
import 'package:frontend/components/background.dart';
import 'package:frontend/components/formfield.dart';
import 'package:frontend/constants/constants.dart';

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
        BackgroundDesign(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 70.0, bottom: 20.0),
                child: Column(
                  children: [
                    Text(
                      "Registered as Alumni",
                      style: kRegisterHeading,
                    ),
                    Text(
                      "Please set your profile",
                      style: kRegisterSubHeading,
                    ),
                  ],
                ),
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
                padding: const EdgeInsets.only(top: 40.0),
                child: MyTextField(
                  label: "Full Name",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: MyTextField(
                  label: "Year of Passout",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: MyTextField(
                  label: "Department",
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
