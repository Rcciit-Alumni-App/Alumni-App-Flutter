import 'package:flutter/material.dart';
import 'package:frontend/components/background_add_details_page.dart';
import 'package:frontend/components/button.dart';
import 'package:frontend/components/button3.dart';
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
        BackgroundAddDetailsPage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.only(top: 70.0, left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello Name",
                  style: kRegisterHeading,
                ),
                Text(
                  "Please fill in the rest of your details",
                  style: kRegisterSubHeading,
                ),
                SizedBox(
                  height: 65.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: MyTextField(
                    label: "Full Name",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: MyTextField(
                    label: "Email",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: MyTextField(
                    label: "Phone Number",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: MyTextField(
                    label: "University Roll(you cannot change this later)",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: MyTextField(
                    label: "College Roll",
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CustomButton3(
                    label: "Next",
                    onPressed: () {},
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
