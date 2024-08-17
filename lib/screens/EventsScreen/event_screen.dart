import 'package:flutter/material.dart';
import 'package:frontend/components/bottomnavbar.dart';
import 'package:frontend/models/EventsModel.dart';
import 'package:frontend/screens/HomeScreen/CampusSection/campus_card.dart';
import 'package:frontend/screens/HomeScreen/EventsSection/events_card.dart';
import 'package:frontend/services/event_service.dart';
import 'package:frontend/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  late EventService eventService;
  List<EventsCardmodel>? eventsModel;
  NavigationService navigation = NavigationService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eventService= GetIt.instance<EventService>();
    getEvents().then((value) => {
          setState(() {
            eventsModel = value;
            debugPrint("EventsModel" + eventsModel.toString());
          })
        });
  }

  Future getEvents() async {
    try {
      return await eventService.getAllEvents();
    } catch (e) {
      debugPrint("Error: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
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
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Events',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              ),
              
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: MediaQuery.of(context).size.height * 1,
            child: eventsModel == null
                ? Center(
                    child: CircularProgressIndicator()) 
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: eventsModel!.length+1,
                    itemBuilder: (context, index) {
                      if(index == eventsModel!.length){
                        return Container(
                          height: 50,
                          width: 50,
                          child: Center(
                            child: Text('No more news'),
                          ),
                        );
                      }
                      else{
                        return CampusCard(
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

 
}
