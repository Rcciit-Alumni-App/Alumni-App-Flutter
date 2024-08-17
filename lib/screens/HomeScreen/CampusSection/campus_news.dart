import 'package:flutter/material.dart';
import 'package:frontend/models/NewsModel.dart';
import 'package:frontend/screens/CampusScreen/campus_screen.dart';
import 'package:frontend/screens/CampusScreen/news_details.dart';
import 'package:frontend/screens/HomeScreen/CampusSection/campus_card.dart';
import 'package:frontend/services/navigation_service.dart';
import 'package:frontend/services/news_service.dart';
import 'package:get_it/get_it.dart';

class CampusNews extends StatefulWidget {
  const CampusNews({super.key});

  @override
  State<CampusNews> createState() => _CampusNewsState();
}

class _CampusNewsState extends State<CampusNews> {
  late NewsService newsService;
  List<NewsCardModel>? newsModel;
  NewsModel? news;
  NavigationService navigation = NavigationService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newsService = GetIt.instance<NewsService>();
    getNews().then((value) => {
          setState(() {
            newsModel = value;
            //debugPrint("NewsModel" + newsModel.toString());
          })
        });
  }

  Future getNews() async {
    try {
      return await newsService.getAllnews();
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  Future getNewsbyId(String id) async {
    try {
      return await newsService.getNewsById(id);
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
                'CAMPUS NEWS',
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
                          .push(navigation.createRoute(route: CampusScreen()));
                    },
                    child: Text('Show More'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            child: newsModel == null
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      if (index == 3) {
                        return CircularViewMore(context);
                      } else {
                        return CampusCard(
                          title: newsModel![index].title,
                          desc: newsModel![index].description,
                          id: newsModel![index].id,
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
            Navigator.of(context)
                .push(navigation.createRoute(route: CampusScreen()));
          },
        ),
      ),
    );
  }
}
