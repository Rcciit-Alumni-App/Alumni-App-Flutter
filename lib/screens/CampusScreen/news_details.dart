import 'package:flutter/material.dart';
import 'package:frontend/components/Buttons/button2.dart';
import 'package:frontend/components/bottomnavbar.dart';
import 'package:frontend/components/Buttons/button3.dart';
import 'package:frontend/constants/constants.dart';
import 'package:frontend/models/NewsModel.dart';
import 'package:intl/intl.dart';  

class NewsDetails extends StatefulWidget {
  final NewsModel? news;
  const NewsDetails({super.key, required this.news});

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.news!.title,
              style: kEventNewsHeading,
            ),
            SizedBox(height: 20.0),
            Container(
              height: 200.0,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(" - "),
                CircleAvatar(
                  radius: 15.0,
                  backgroundImage: AssetImage('assets/default-user.jpg'),
                ),
                Text(
                  '${widget.news!.author?.fullName ?? 'Unknown'}, ${DateFormat.yMd().format(widget.news!.created_at)}', 
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  widget.news!.description,
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                fillColor: Colors.grey[300],
                hintText: 'Add a comment',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
      bottomNavigationBar: Bottomnavbar(),
    );
  }
}
