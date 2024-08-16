import 'package:flutter/material.dart';
import 'package:frontend/screens/ChatScreen/chat_screen.dart';
import 'package:frontend/screens/DigitalID/digital_id.dart';
import 'package:frontend/screens/DonationScreen/donation_screen.dart';
import 'package:frontend/screens/HomeScreen/home_screen.dart';
import 'package:frontend/screens/ProfileScreen/profile_screen.dart';
import 'package:frontend/screens/register/alumni/register_alumni_edu.dart';
import 'package:frontend/screens/register/alumni/register_alumni_work.dart';
import 'package:frontend/screens/register/alumni/register_profile_alumni.dart';
import 'package:frontend/screens/register/register_main.dart';
import 'package:frontend/screens/register/student/register_profile_student.dart';
import 'package:frontend/screens/register/student/register_student_domain.dart';
import 'package:frontend/screens/register/student/register_student_work.dart';


class NavigationService {
  late GlobalKey<NavigatorState> navigatorKey;
  final Map<String, Widget Function(BuildContext)> routes = {
    '/home': (context) => const HomePage(),
    '/chat': (context) => const ChatPage(),
    '/donation': (context) => const DonationPage(),
    '/profile': (context) => const ProfilePage(),
    '/alumni-profile': (context) => const RegisterProfileAlumni(),
    '/alumni-work': (context) => RegisterAlumniWork(),
    '/alumni-education': (context) => RegisterAlumniEdu(),
    '/student-profile': (context) => const RegisterProfileStudent(),
    '/student-work': (context) => RegisterStudentWork(),
    '/student-other-details': (context) => RegisterStudentDomain(),
    '/register-main': (context) => const RegisterMain(),
    '/digitalId': (context) => const DigitalId(),
  };

  GlobalKey<NavigatorState>? get nav {
    return navigatorKey;
  }

  Map<String, Widget Function(BuildContext)> get route {
    return routes;
  }

  NavigationService() {
    navigatorKey = GlobalKey<NavigatorState>();
  }

  void push(MaterialPageRoute route) {
    navigatorKey.currentState?.push(route);
  }

  void pushNamed(String routeName) {
    navigatorKey.currentState?.pushNamed(routeName);
  }
  void pushReplacementNamed (String routeName) {
    navigatorKey.currentState?.pushReplacementNamed(routeName);
  }
  void goback (){
    navigatorKey.currentState?.pop();
  }
  Route createRoute({required Widget route}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
         route,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        var opacityAnimation = animation.drive(tween);

        return FadeTransition(
          opacity: opacityAnimation,
          child: child,
        );
      },
    );
  }
}