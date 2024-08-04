import 'package:flutter/material.dart';
import 'package:frontend/components/bottomnavbar.dart';
import 'package:frontend/components/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

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
      drawer: Drawer(
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
                        const Text(
                          'Saban Adhikari',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _createDrawerItem(
              context,
              text: 'Jobs/Internships',
              index: 0,
            ),
            _createDrawerItem(
              context,
              text: 'Workshops',
              index: 1,
            ),
            _createDrawerItem(
              context,
              text: 'Career Counselling',
              index: 2,
            ),
            _createDrawerItem(
              context,
              text: 'Referrals',
              index: 3,
            ),
            _createDrawerItem(
              context,
              text: 'Donations',
              index: 4,
            ),
            _createDrawerItem(
              context,
              text: 'Settings',
              index: 5,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: CustomButton(label: 'Logout', onPressed: () {}),
            ),
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
