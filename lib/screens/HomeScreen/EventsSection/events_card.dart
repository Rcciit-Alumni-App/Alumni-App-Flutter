import 'package:flutter/material.dart';
import 'package:frontend/components/Buttons/button.dart';
import 'package:frontend/models/EventsModel.dart';
import 'package:frontend/screens/EventsScreen/event_details.dart';
import 'package:frontend/services/event_service.dart';
import 'package:frontend/services/navigation_service.dart';
import 'package:get_it/get_it.dart';



class EventsCard extends StatefulWidget {
  final String? title;
  final String? desc;
  final String? id;
  final String? date;
  const EventsCard({super.key, required this.title, required this.desc, required this.id, required this.date});

  @override
  State<EventsCard> createState() => _EventsCardState();
}

class _EventsCardState extends State<EventsCard> {
  NavigationService navigation = NavigationService();

  late EventService eventService;
  Eventsmodel? eventModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventService = GetIt.instance<EventService>();
  }

  Future getEvents() async {
    try {
      return await eventService.getEventsById(widget.id!);
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
     return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          getEvents().then((value) => {
                setState(() {
                  Eventsmodel eventModel = value;
                  debugPrint("EventsModel" + eventModel.toString());
                  Navigator.of(context).push(navigation.createRoute(
                      route: EventDetails(
                    event: eventModel,
                  )));
                })
              });
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: List.generate(
              5,
              (index) => BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ),
          ),
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(217, 217, 217, 1),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.title!,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 5),
               Text(
                widget.date!,
                style: TextStyle(fontSize: 10),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                widget.desc!,
                style: TextStyle(fontSize: 10),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 14),
              Align(
                alignment: Alignment.centerRight,
                child: CustomButton(
                  label: 'View More',
                  width: 90,
                  height: 35,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}