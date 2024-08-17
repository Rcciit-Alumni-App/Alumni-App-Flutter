import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/EventsModel.dart';
import 'package:frontend/screens/EventsScreen/event_screen.dart';
import 'package:frontend/screens/HomeScreen/EventsSection/events_card.dart';
import 'package:frontend/services/event_service.dart';
import 'package:frontend/services/navigation_service.dart';
import 'package:frontend/services/news_service.dart';
import 'package:get_it/get_it.dart';


class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  late EventService eventService;
  List<EventsCardmodel>? eventsModel;
  NavigationService navigation = NavigationService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventService= GetIt.instance<EventService>();
    getNews().then((value) => {
          setState(() {
            eventsModel = value;
            debugPrint("EventsModel" + jsonEncode(eventsModel));
          })
        });
  }

  Future getNews() async {
    try {
      return await eventService.getAllEvents();
    } catch (e) {
      debugPrint("Error: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'EVENTS',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              ),
              Spacer(),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(navigation.createRoute(route: EventScreen()));
                    },
                    child: Text('Show More'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            child: eventsModel == null
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      if (index == 3) {
                        return CircularViewMore(context);
                      } else {
                        return EventsCard(
                          title: eventsModel![index].eventName,
                          desc: eventsModel![index].description[0],
                          id: eventsModel![index].id,
                        );
                      }
                    },
                  ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
   Widget CircularViewMore(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.blue,
        child: IconButton(
          icon: Icon(Icons.arrow_forward, color: Colors.white),
          onPressed: () {
          },
        ),
      ),
    );
  }
}