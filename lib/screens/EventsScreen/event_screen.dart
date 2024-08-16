import 'package:flutter/material.dart';
import 'package:frontend/components/bottomnavbar.dart';
import 'package:frontend/screens/HomeScreen/CampusSection/campus_card.dart';
import 'package:frontend/screens/HomeScreen/EventsSection/events_card.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
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
                  child: EventsCard(),
                );
              
            }),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

 
}
