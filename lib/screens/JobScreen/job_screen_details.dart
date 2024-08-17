import 'package:flutter/material.dart';
import 'package:frontend/components/Buttons/button2.dart';
import 'package:frontend/components/bottomnavbar.dart';
import 'package:frontend/components/Buttons/button3.dart';
import 'package:frontend/components/formfield.dart';
import 'package:frontend/constants/constants.dart';

class JobDetails extends StatefulWidget {
  const JobDetails({super.key});

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: CustomButton2(
                label: "Back",
                onPressed: () {},
              ),
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.grey,
                ),
                SizedBox(width: 15,),
                Column(
                  children: [
                    Text(
                      'NYZ ABC',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Has posted this job opportunity\non' + 'dd/mm/yyyy',
                      style: TextStyle(
                          fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.03,
            ),
            Expanded(
              child: ListView(
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Job Role: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Software Developer I',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).width * 0.05,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Company: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'hehe',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).width * 0.05,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse.',
                        ),
                        TextSpan(
                          text: '\n\n',
                        ),
                        TextSpan(
                          text: 'Responsibilities:',
                        ),
                        TextSpan(
                          text: '\n\n',
                        ),
                        TextSpan(
                          text: 'random stuff',
                        ),
                        TextSpan(text: '\n\n'),

                        TextSpan(
                          text: 'Responsibilities:',
                        ),

                        TextSpan(text: '\n\n'),

                        TextSpan(text: 'some more random stuff')
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomButton3(label: 'Apply Now', onPressed: () {}),
          SizedBox(height: 20),
          Bottomnavbar(),
        ],
      ),
    );
  }
}
