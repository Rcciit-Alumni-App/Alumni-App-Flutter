import 'package:flutter/material.dart';
import 'package:frontend/screens/HomeScreen/EventsSection/events_card.dart';

class Events extends StatelessWidget {
  const Events({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
                    onPressed: () {},
                    child: Text('Show More'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: MediaQuery.of(context).size.height * 0.32,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4, 
              itemBuilder: (context, index) {
                if (index == 3) {
                  return CircularViewMore();
                } else {
                  return EventsCard();
                }
              },
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
 

  Widget CircularViewMore() {
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