import 'package:flutter/material.dart';
import 'package:frontend/screens/chat_screen.dart';
import 'package:frontend/screens/donation_screen.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/screens/profile_screen.dart';

class NavigationService {
  late GlobalKey<NavigatorState> navigatorKey;
  final Map<String, Widget Function(BuildContext)> routes = {
    '/home': (context) => const HomePage(),
    '/chat': (context) => const ChatPage(),
    '/donation': (context) => const DonationPage(),
    '/profile': (context) => const ProfilePage(),
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