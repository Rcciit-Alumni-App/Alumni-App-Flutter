import 'package:flutter/material.dart';
import 'package:frontend/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  late NavigationService navigationService;
  int _selectedIndex = 1;

  final List<String> _routes = [
    '/home',
    '/donation',
    '/chat',
    '/profile',
  ];

  @override
  void initState() {
    super.initState();
    navigationService = GetIt.instance.get<NavigationService>();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    navigationService.pushNamed(_routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      selectedItemColor: Theme.of(context).colorScheme.surface,
      unselectedItemColor: Theme.of(context).colorScheme.surface,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          icon: ImageIcon(AssetImage('assets/home.png'),
            size: 30.0,),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          icon: ImageIcon(AssetImage('assets/wallet.png'),
            size: 30.0,),
          label: 'Wallet',
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          icon: ImageIcon(AssetImage('assets/chat.png',),
            size: 40.0,
          ),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          icon: ImageIcon(AssetImage('assets/person.png'),
            size: 30.0,),
          label: 'Profile',
        ),
      ],
    );
  }
}

