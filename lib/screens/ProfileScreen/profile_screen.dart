import 'package:flutter/material.dart';
import 'package:frontend/components/Background/background_add_details_page.dart';
import 'package:frontend/components/Buttons/button4.dart';
import 'package:frontend/components/Buttons/buttonProfile.dart';
import 'package:frontend/components/bottomnavbar.dart';
import 'package:frontend/components/formfield.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/screens/register/student/register_student_work.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundAddDetailsPage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.only(top: 130.0, left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage: AssetImage("assets/default-user.jpg"),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton4(
                      label: "View Profile",
                      onPressed: () {},
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    CustomButton4(
                      label: "Edit Profile",
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                ProfileButton(
                  text: "My Posts",
                  icons: Icons.add_circle,
                ),
                SizedBox(
                  height: 30.0,
                ),
                ProfileButton(
                  text: "My Donations",
                ),
                SizedBox(
                  height: 30.0,
                ),
                ProfileButton(
                  text: "My Digital Cards",
                  icons: Icons.add_circle,
                ),
                SizedBox(
                  height: 30.0,
                ),
                ProfileButton(
                  text: "My Posted Jobs",
                  icons: Icons.add_circle,
                ),
                SizedBox(
                  height: 30.0,
                ),
                ProfileButton(
                  text: "My Posted Interships",
                  icons: Icons.add_circle,
                ),
              ],
            ),
          ),
          bottomNavigationBar: Bottomnavbar(),
        )
      ],
    );
  }
}
