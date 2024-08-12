import 'package:flutter/material.dart';
import 'package:frontend/screens/CampusScreen/campus_screen.dart';
import 'package:frontend/screens/auth_view/login_page.dart';
import 'package:frontend/screens/HomeScreen/home_screen.dart';
import 'package:frontend/screens/register/alumni/register_alumni_work.dart';
import 'package:frontend/screens/auth_view/signup_page.dart';
import 'package:frontend/screens/register/alumni/register_alumni_work.dart';
import 'package:frontend/screens/register/register_main.dart';
import 'package:frontend/screens/register/student/register_student_work.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/services/navigation_service.dart';
import 'package:frontend/utils.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'constants/colors.dart';

void main() async {
  await setup();
  runApp(MyApp());
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await registerService();
}

class MyApp extends StatelessWidget {
  final GetIt getIt = GetIt.instance;
  late NavigationService navigationService;

  MyApp({super.key}) {
    navigationService = getIt.get<NavigationService>();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        navigatorKey: navigationService.navigatorKey,
        debugShowCheckedModeBanner: false,
        // initialRoute: "/home",
        routes: navigationService.routes,
        theme: lightMode.copyWith(
          textTheme: GoogleFonts.nunitoTextTheme(),
        ),
        home: CampusScreen(),
      ),
    );
  }
}
