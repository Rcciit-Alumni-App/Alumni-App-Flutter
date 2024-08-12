import 'package:flutter/material.dart';
import 'package:frontend/components/Background/background_digital_id.dart';
import 'package:frontend/components/Buttons/button2.dart';
import 'package:frontend/components/bottomnavbar.dart';
import 'package:frontend/constants/constants.dart';

class DigitalId extends StatefulWidget {
  const DigitalId({super.key});

  @override
  State<DigitalId> createState() => _DigitalIdState();
}

class _DigitalIdState extends State<DigitalId> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundDigitalId(),
        Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: const EdgeInsets.all(15.0), // Added padding to the container
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 2.0,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Minimize the size to fit content
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/RCCIIT_logo.png",
                          height: 70.0,
                        ),
                        Image.asset(
                          "assets/alumni_logo_1.png",
                          height: 70.0,
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0),
                    CircleAvatar(
                      radius: 80.0,
                      backgroundImage: AssetImage("assets/default-user.jpg"),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "XYZ ABC",
                      style: kIdNameStyle,
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Year of Passout: ",
                          style: kIdDetailsCaptionStyle,
                        ),
                        Flexible(
                          child: Text(
                            "2027",
                            style: kIdDetailsFieldStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Stream: ",
                          style: kIdDetailsCaptionStyle,
                        ),
                        Flexible(
                          child: Text(
                            "Computer Science and Engineering",
                            style: kIdDetailsFieldStyle,
                            overflow: TextOverflow.visible,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "University Roll: ",
                          style: kIdDetailsCaptionStyle,
                        ),
                        Flexible(
                          child: Text(
                            "XXXXXXXXXX",
                            style: kIdDetailsFieldStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    CustomButton2(
                      label: "View Details",
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Bottomnavbar(),
        ),
      ],
    );
  }
}
