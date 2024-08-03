import 'package:flutter/material.dart';
import 'package:frontend/components/background.dart';
import 'package:frontend/components/formfield.dart';
import 'package:frontend/constants/constants.dart';

class RegisterMain extends StatefulWidget {
  const RegisterMain({super.key});

  @override
  State<RegisterMain> createState() => _RegisterMainState();
}

class _RegisterMainState extends State<RegisterMain> {
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
                padding: EdgeInsets.only(top: 70.0),
                child: Column(
                  children: [
                    Text(
                      "Hello Name",
                      style: kRegisterHeading,
                    ),
                    Text(
                      "Please fill in the rest of your details",
                      style: kRegisterSubHeading,
                    ),
                  ],
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
                  label: "Email",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: MyTextField(
                  label: "Phone Number",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: MyTextField(
                  label: "University Roll(you cannot change this later)",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: MyTextField(
                  label: "College Roll",
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
