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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            // Removed the padding from here
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary,
                width: 2.0,
              ),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        18.0), // Adjust this to match the container's border radius
                    child: BackgroundDigitalId(),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.all(15.0), // Moved padding to content
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        height: 120.0,
                        width: 120.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      CustomButton2(
                        label: "View Details",
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Bottomnavbar(),
    );
  }
}
