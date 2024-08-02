import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: uiBuild(),
      bottomNavigationBar: bottomnavbar(),
    );
  }

  Widget uiBuild() {
    return Scaffold();
  }

  Widget bottomnavbar() {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      selectedItemColor: Theme.of(context).colorScheme.surface,
      unselectedItemColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items:  <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          icon: Icon(Icons.wallet),
          label: 'B',
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          icon: Icon(Icons.chat),
          label: 'School',
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
