import 'package:flutter/material.dart';
import 'package:frontend/components/bottomnavbar.dart';
import 'package:frontend/screens/HomeScreen/CampusSection/campus_card.dart';

class CampusScreen extends StatefulWidget {
  const CampusScreen({super.key});

  @override
  State<CampusScreen> createState() => _CampusScreenState();
}

class _CampusScreenState extends State<CampusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            uiBuild(),
          ],
        ),
      ),
      bottomNavigationBar: Bottomnavbar(),
    );
  }

  Widget uiBuild() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Column(
            children: List.generate(4, (index) {
              
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CampusCard(),
                );
              
            }),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

 
}
