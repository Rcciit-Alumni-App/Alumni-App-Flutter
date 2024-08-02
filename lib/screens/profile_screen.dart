import 'package:flutter/material.dart';
import 'package:frontend/components/bottomnavbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to the Profile Page',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
        bottomNavigationBar: Bottomnavbar(),
    );
  }
}