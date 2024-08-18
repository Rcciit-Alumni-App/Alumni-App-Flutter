import 'package:flutter/material.dart';
import 'package:frontend/components/Buttons/button.dart';
import 'package:frontend/models/JobsModel.dart';
import 'package:frontend/screens/JobScreen/job_details.dart';
import 'package:frontend/services/job_service.dart';
import 'package:frontend/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

class JobsCard extends StatefulWidget {
  final String? id;
  final String? title;
  final String? role;
  final String? company;
  final String? description;
  const JobsCard({super.key, this.title, this.role, this.company, this.description, this.id});

  @override
  State<JobsCard> createState() => _JobsCardState();
}

class _JobsCardState extends State<JobsCard> {
  NavigationService navigation = NavigationService();

  late JobService jobsService;
  JobsCardModel? jobsModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jobsService = GetIt.instance<JobService>();
  }

  Future getJobs() async {
    try {
      return await jobsService.getJobsById(widget.id!);
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
          getJobs().then((value) => {
                setState(() {
                  JobModel jobModel = value;
                  debugPrint("JobModel" + jobModel.toString());
                  Navigator.of(context).push(navigation.createRoute(
                      route: JobDetails(
                    job: jobModel,
                  )));
                })
              });
        },
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
                        widget.title!,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Type: ${widget.role!}',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Company: ${widget.company!}',
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
                widget.description!,
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
      ),
    );
  }
}
