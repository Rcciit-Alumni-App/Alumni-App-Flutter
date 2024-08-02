import 'package:flutter/material.dart';
import 'package:frontend/components/background.dart';
import 'package:frontend/components/formfield.dart';
import 'package:frontend/constants/constants.dart';

class RegisterAlumniWork extends StatefulWidget {
  const RegisterAlumniWork({super.key});

  @override
  State<RegisterAlumniWork> createState() => _RegisterAlumniWorkState();
}

class _RegisterAlumniWorkState extends State<RegisterAlumniWork> {
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
            ],
          ),
        )
      ],
    );
  }
}
