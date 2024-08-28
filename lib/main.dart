import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/screens/CampusScreen/campus_screen.dart';
import 'package:frontend/screens/CampusScreen/news_details.dart';
import 'package:frontend/screens/DigitalID/digital_id.dart';
import 'package:frontend/screens/EventsScreen/event_details.dart';
import 'package:frontend/screens/EventsScreen/event_screen.dart';
import 'package:frontend/screens/JobScreen/job_details.dart';
import 'package:frontend/screens/auth_view/forgot_password_page.dart';
import 'package:frontend/screens/auth_view/forgot_password_page_email.dart';
import 'package:frontend/screens/auth_view/login_page.dart';
import 'package:frontend/screens/HomeScreen/home_screen.dart';
import 'package:frontend/screens/auth_view/verification_screen_signup.dart';
import 'package:frontend/screens/register/alumni/register_alumni_edu.dart';
import 'package:frontend/screens/register/alumni/register_alumni_work.dart';
import 'package:frontend/screens/auth_view/signup_page.dart';
import 'package:frontend/screens/register/alumni/register_alumni_work.dart';
import 'package:frontend/screens/register/alumni/register_profile_alumni.dart';
import 'package:frontend/screens/register/register_main.dart';
import 'package:frontend/screens/register/student/register_profile_student.dart';
import 'package:frontend/screens/register/student/register_student_domain.dart';
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
  final storage = new FlutterSecureStorage();

  MyApp({super.key}) {
    navigationService = getIt.get<NavigationService>();
  }

  Future<String?> _getUserToken() async {
    return await storage.read(key: "accessToken");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getUserToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Stack(
              children: [
                Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ], 
            ),
          );
        }

        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text("An error occurred: ${snapshot.error}"),
              ),
            ),
          );
        }

        String? token = snapshot.data;

        return ChangeNotifierProvider(
          create: (context) => UserProvider(),
          child: MaterialApp(
            navigatorKey: navigationService.navigatorKey,
            debugShowCheckedModeBanner: false,
            routes: navigationService.routes,
            theme: lightMode.copyWith(
              textTheme: GoogleFonts.nunitoTextTheme(),
            ),
            home: token == null ? LoginPage() : HomePage(),
          ),
        );
      },
    );
  }
}
