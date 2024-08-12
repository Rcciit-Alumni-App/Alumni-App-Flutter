import 'package:flutter/material.dart';
import 'package:frontend/components/Drawer/drawer_screen.dart';
import 'package:frontend/components/bottomnavbar.dart';
import 'package:frontend/components/Buttons/button.dart';
import 'package:frontend/models/UserModel.dart';
import 'package:frontend/screens/HomeScreen/CampusSection/campus_news.dart';
import 'package:frontend/screens/HomeScreen/EventsSection/events.dart';
import 'package:frontend/screens/auth_view/login_page.dart';
import 'package:frontend/services/alert_services.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final AuthService _authService = AuthService();
  final NavigationService navigation = NavigationService();
  late AlertService _alertService;
  UserModel? user;

  @override
  void initState() {
    // TODO: implement initState
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
    return Scaffold(
      body: uiBuild(),
    );
  }

  Widget uiBuild() {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: ImageIcon(
                AssetImage('assets/opendraw.png'),
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: DrawerScreen(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CampusNews(),
            Events()
          ],
        ),
      ),
      bottomNavigationBar: Bottomnavbar(),
    );
  }

  
 
}
