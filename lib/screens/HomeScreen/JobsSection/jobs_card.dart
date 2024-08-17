import 'package:flutter/material.dart';
import 'package:frontend/components/Buttons/button.dart';

class JobsCard extends StatefulWidget {
  const JobsCard({super.key});

  @override
  State<JobsCard> createState() => _JobsCardState();
}

class _JobsCardState extends State<JobsCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.28,
        padding: const EdgeInsets.all(18.0),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.grey[300], 
                  child: Icon(
                    Icons.person,
                    size: 30.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'ABC XYZ',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Job Role: xyz',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Company: abc',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore aliqua...',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[600],
              ),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerRight,
              child: CustomButton(
                label: 'Apply',
                width: 90,
                height: 35,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
