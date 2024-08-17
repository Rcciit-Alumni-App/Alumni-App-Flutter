import 'package:flutter/material.dart';
import 'package:frontend/components/Buttons/button2.dart';
import 'package:frontend/components/bottomnavbar.dart';
import 'package:frontend/components/Buttons/button3.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/models/EventsModel.dart';
import 'package:frontend/services/event_service.dart';
import 'package:frontend/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

class EventDetails extends StatefulWidget {
  final Eventsmodel? event;
  const EventDetails({super.key, required this.event});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.event!.eventName,
                      style: kEventNewsHeading,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 200.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    widget.event!.description[0],
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 40.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton2(
                        label: "Show Interest",
                        onPressed: () {},
                      ),
                      SizedBox(width: 10.0),
                      CustomButton3(
                        label: "Register",
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
           
          ],
        ),
      ),
      bottomNavigationBar: Bottomnavbar(),
    );
  }
}
