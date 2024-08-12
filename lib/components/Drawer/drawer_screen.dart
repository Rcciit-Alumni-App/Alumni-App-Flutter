import 'package:flutter/material.dart';
import 'package:frontend/components/Buttons/button.dart';
import 'package:frontend/models/UserModel.dart';
import 'package:frontend/screens/auth_view/login_page.dart';
import 'package:frontend/services/alert_services.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  int _selectedIndex = 10;
  final AuthService _authService = AuthService();
  final NavigationService navigation = NavigationService();
  late AlertService _alertService;
  UserModel? user;

  @override
  void initState() {
    super.initState();
    _alertService = GetIt.instance.get<AlertService>();
    _getUser().then((value) {
      setState(() {
        user = value;
        debugPrint(user.toString());
      });
    });
  }

  Future<void> _logout() async {
    try {
      await _authService.logout();
      _alertService.showSnackBar(
          message: "Logout Successful",
          color: Theme.of(context).colorScheme.secondary);
      Navigator.of(context)
          .pushReplacement(navigation.createRoute(route: LoginPage()));
    } catch (e) {
      print(e);
    }
  }

  Future<UserModel> _getUser() async {
    try {
      UserModel? user = await _authService.getUserProfile();
      print(user.personalMail);
      return user;
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shadowColor: Colors.grey.shade100,
      elevation: 1,
      width: MediaQuery.of(context).size.width * 0.7,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white,
                        width: 0.0,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            AssetImage('assets/default-user.jpg'),
                      ),
                      const SizedBox(height: 10),
                      Text(
                         user?.personalMail ?? 'User',
                        //'User',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _createDrawerItem(context, text: 'Jobs/Internships', index: 0),
          _createDrawerItem(context, text: 'Workshops', index: 1),
          _createDrawerItem(context, text: 'Career Counselling', index: 2),
          _createDrawerItem(context, text: 'Referrals', index: 3),
          _createDrawerItem(context, text: 'Donations', index: 4),
          _createDrawerItem(context, text: 'Settings', index: 5),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: CustomButton(
              label: 'Logout',
              onPressed: () {
                _logout();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem(BuildContext context,
      {required String text, required int index}) {
    bool selected = _selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          color: selected ? Colors.blue.shade100 : Colors.transparent,
          child: ListTile(
            title: Text(
              text,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              // Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
