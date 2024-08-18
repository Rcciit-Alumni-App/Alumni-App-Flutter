import 'package:flutter/material.dart';
import 'package:frontend/components/Background/background_add_details_page.dart';
import 'package:frontend/components/Buttons/buttonProfile.dart';
import 'package:frontend/components/bottomnavbar.dart';
import 'package:frontend/screens/CreatePost/create_post.dart';
import 'package:frontend/services/navigation_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final NavigationService navigation = NavigationService();
  @override
  Widget build(BuildContext context) {
    return  Stack(
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
                ProfileButton(
                  text: "My Posts",
                  icons: GestureDetector(
                    onTap: (){
                      Navigator.of(context)
                          .push(navigation.createRoute(route: CreatePost()));
                    },
                    child: Icon(Icons.add_circle,color: Theme.of(context).colorScheme.primary)),
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
                  icons: Icon(Icons.add_circle,color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(
                  height: 30.0,
                ),
                ProfileButton(
                  text: "My Posted Jobs",
                  icons: Icon(Icons.add_circle,color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(
                  height: 30.0,
                ),
                ProfileButton(
                  text: "My Posted Interships",
                  icons: Icon(Icons.add_circle,color: Theme.of(context).colorScheme.primary,),
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