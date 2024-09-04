import 'package:flutter/material.dart';
import 'package:frontend/components/bottomnavbar.dart';
import 'package:frontend/models/NewsModel.dart';
import 'package:frontend/screens/HomeScreen/CampusSection/campus_card.dart';
import 'package:frontend/services/navigation_service.dart';
import 'package:frontend/services/news_service.dart';
import 'package:get_it/get_it.dart';

class CampusScreen extends StatefulWidget {
  const CampusScreen({super.key});

  @override
  State<CampusScreen> createState() => _CampusScreenState();
}

class _CampusScreenState extends State<CampusScreen> {
  late NewsService newsService;
  List<NewsCardModel>? newsModel;
  NavigationService navigation = NavigationService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newsService = GetIt.instance<NewsService>();
    getNews().then((value) => {
          setState(() {
            newsModel = value;
            debugPrint("NewsModel" + newsModel.toString());
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                'CAMPUS NEWS',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              ),
              
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: MediaQuery.of(context).size.height * 0.77,
            child: newsModel == null
                ? Center(
                    child: CircularProgressIndicator()) 
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: newsModel!.length+1,
                    itemBuilder: (context, index) {
                      if(index == newsModel!.length){
                        return Container(
                          height: 50,
                          width: 50,
                          child: Center(
                            child: Text('No more news'),
                          ),
                        );
                      }
                      else{
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

 
}
