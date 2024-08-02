import 'package:flutter/material.dart';
import 'package:frontend/components/bottomnavbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                color: Theme.of(context).colorScheme.secondary, // Replace with your custom icon path
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
           DrawerHeader(
  decoration: BoxDecoration(
    color: Colors.white,
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // Optionally, you can add other widgets here
      Text('Header Title', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      IconButton(
        icon: ImageIcon(
          AssetImage('assets/opendraw.png'),
          color: Theme.of(context).colorScheme.secondary, // Replace with your custom icon path
        ),
        onPressed: () {
          // You can add functionality here if needed
        },
      ),
    ],
  ),
),
            _createDrawerItem(
              context,
              text: 'Jobs/Internships',
              selected: true,
            ),
            _createDrawerItem(
              context,
              text: 'Workshops',
            ),
            _createDrawerItem(
              context,
              text: 'Career Counselling',
            ),
            _createDrawerItem(
              context,
              text: 'Referrals',
            ),
            _createDrawerItem(
              context,
              text: 'Donations',
            ),
            _createDrawerItem(
              context,
              text: 'Settings',
            ),
            const SizedBox(height: 20),
           
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Welcome to the Home Page',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Bottomnavbar(),
    );
  }

  Widget _createDrawerItem(BuildContext context, {required String text, bool selected = false}) {
    return Container(
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
          Navigator.pop(context);
          // Navigate to the corresponding screen
        },
      ),
    );
  }
}
