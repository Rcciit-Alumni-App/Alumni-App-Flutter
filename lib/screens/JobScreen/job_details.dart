import 'package:flutter/material.dart';
import 'package:frontend/components/bottomnavbar.dart';
import 'package:frontend/components/Buttons/button3.dart';
import 'package:frontend/models/JobsModel.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class JobDetails extends StatefulWidget {
  JobModel job;
  JobDetails({super.key, required this.job});

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
            //   child: CustomButton2(
            //     label: "Back",
            //     onPressed: () {},
            //   ),
            // ),
            Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  children: [
                    Text(
                      widget.job.title,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Has posted this job opportunity\non ' + DateFormat.yMd().format(DateTime.parse(widget.job.posted_at)),
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
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
                          text: widget.job.company_name,
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
                          text: widget.job.description,
                        ),
                        TextSpan(
                          text: '\n\n',
                        ),
                        TextSpan(
                          text: 'Location:',
                        ),
                        TextSpan(
                          text: widget.job.location,
                        ),
                        TextSpan(
                          text: '\nApplication Deadline:',
                        ),
                        TextSpan(text: DateFormat.yMd().format(DateTime.parse(widget.job.application_deadline))),

                        // TextSpan(
                        //   text: 'Responsibilities:',
                        // ),

                        // TextSpan(text: '\n\n'),

                        // TextSpan(text: 'some more random stuff')
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
          CustomButton3(
              label: 'Apply Now',
              onPressed: () async {
                Uri url = Uri.parse(widget.job.apply_link);
                if (!await launchUrl(url)) {
                  throw 'Could not launch $url';
                }
              }),
          SizedBox(height: 20),
          Bottomnavbar(),
        ],
      ),
    );
  }
}
