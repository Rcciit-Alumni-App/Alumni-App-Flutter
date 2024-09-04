import 'package:flutter/material.dart';
import 'package:frontend/models/JobsModel.dart';
import 'package:frontend/screens/HomeScreen/JobsSection/jobs_card.dart';
import 'package:frontend/screens/JobScreen/jobs_screen.dart';
import 'package:frontend/services/job_service.dart';
import 'package:frontend/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

class Jobs extends StatefulWidget {
  const Jobs({super.key});

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  late JobService jobsService;
  List<JobsCardModel>?jobsModel;
  //NewsModel? news;
  NavigationService navigation = NavigationService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jobsService = GetIt.instance<JobService>();
    getJobs().then((value) => {
          setState(() {
            jobsModel = value;
            //debugPrint("NewsModel" + newsModel.toString());
          })
        });
  }

  Future getJobs() async {
    try {
      return await jobsService.getAlljobs();
    } catch (e) {
      debugPrint("Error: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Jobs/Internships',
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
                    onPressed: () {
                      Navigator.of(context)
                          .push(navigation.createRoute(route: JobsScreen()));
                    },
                    child: Text('Show More'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
         Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: jobsModel == null
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      if (index == 3) {
                        return CircularViewMore(context);
                      } else {
                        return JobsCard(
                          title: jobsModel![index].title,
                          role: jobsModel![index].job_type,
                          id: jobsModel![index].id,
                          description: jobsModel![index].description,
                          company: jobsModel![index].company_name,
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
  Widget CircularViewMore(BuildContext context) {
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