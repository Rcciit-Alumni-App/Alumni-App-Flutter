import 'package:flutter/material.dart';
import 'package:frontend/components/bottomnavbar.dart';
import 'package:frontend/models/JobsModel.dart';
import 'package:frontend/screens/HomeScreen/JobsSection/jobs_card.dart';
import 'package:frontend/services/job_service.dart';
import 'package:frontend/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
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
                'Jobs/Opportunities',
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
            child: jobsModel == null
                ? Center(
                    child: CircularProgressIndicator()) 
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: jobsModel!.length+1,
                    itemBuilder: (context, index) {
                      if (index == jobsModel!.length) {
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
