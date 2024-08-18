import 'package:flutter/material.dart';
import 'package:frontend/components/Background/background_add_details_page.dart';
import 'package:frontend/components/bottomnavbar.dart';
import 'package:frontend/constants/constants.dart';

class EditProfile extends StatefulWidget {
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundAddDetailsPage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.only(top: 110, left: 10, right: 10),
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage: AssetImage("assets/default-user.jpg"),
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17.0),
                  child: TabBar(
                    controller: tabController,
                    dividerColor: Colors.transparent,
                    tabs: [
                      Tab(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Account',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Work Experience',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Higher Studies',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                    labelColor: Theme.of(context).colorScheme.primary,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        width: 1.11053,
                        color: Color(0xFF2F80ED),
                      ),
                    ), // Sets the bottom line color to blue
                    labelStyle: TextStyle(fontSize: 14.0),
                    unselectedLabelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Divider(
                    color: Theme.of(context).colorScheme.primary,

                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: Bottomnavbar(),
        ),
      ],
    );
  }
}
