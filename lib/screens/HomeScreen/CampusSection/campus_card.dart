import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/components/Buttons/button.dart';
import 'package:frontend/models/NewsModel.dart';
import 'package:frontend/models/UserModel.dart';
import 'package:frontend/screens/CampusScreen/news_details.dart';
import 'package:frontend/services/navigation_service.dart';
import 'package:frontend/services/news_service.dart';
import 'package:get_it/get_it.dart';

class CampusCard extends StatefulWidget {
  final String? title;
  final String? desc;
  final String? id;
  final String? text;
  const CampusCard(
      {super.key, required this.title, required this.desc, required this.id, this.text});

  @override
  State<CampusCard> createState() => _CampusCardState();
}

class _CampusCardState extends State<CampusCard> {
  NavigationService navigation = NavigationService();
  final storage = new FlutterSecureStorage();
  UserModel? user;

  late NewsService newsService;
  NewsModel? newsModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newsService = GetIt.instance<NewsService>();
    getUser().then((value) => {
          setState(() {
            user = value;
          })
        });
  }

  Future getNews() async {
    try {
      return await newsService.getNewsById(widget.id!);
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  Future<UserModel?> getUser() async {
    final user = await storage.read(key:"user");
    return UserModel.fromJson(json.decode(user!));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          getNews().then((value) => {
                setState(() {
                  NewsModel newsModel = value;
                  debugPrint("NewsModel" + newsModel.toString());
                  Navigator.of(context).push(navigation.createRoute(
                      route: NewsDetails(
                    news: newsModel,
                  )));
                })
              });
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.32,
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
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(217, 217, 217, 1),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.title ?? 'Title',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 5),
              Text(
                widget.desc ?? 'Description',
                style: TextStyle(fontSize: 10),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 14),
             
                Row(
                  children: [

                    Spacer(),
                    
                    CustomButton(
                      label: widget.text ?? 'View More',
                      width: 90,
                      height: 35,
                      onPressed: () {
                        getNews().then((value) => {
                setState(() {
                  NewsModel newsModel = value;
                  debugPrint("NewsModel" + newsModel.toString());
                  Navigator.of(context).push(navigation.createRoute(
                      route: NewsDetails(
                    news: newsModel,
                  )));
                })
              });
                      },
                    ),
                  ],
                ),
            
            ],
          ),
        ),
      ),
    );
  }
}
