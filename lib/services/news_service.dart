import 'dart:convert';
//import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/models/NewsModel.dart';
import 'package:http/http.dart' as http;

class NewsService {
  static const String baseUrl = 'http://10.0.2.2:8000/api/v1';
  //static const String baseUrl = 'https://alumni-app-backend-a7b0.onrender.com/api/v1';
  final storage = new FlutterSecureStorage();

 Future<List<NewsCardModel>> getAllnews() async {
  final token = await storage.read(key: "accessToken");
  final response = await http.get(
    Uri.parse('$baseUrl/news/get-all'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200 && response.body.isNotEmpty) {
    final List<dynamic> newsJson = json.decode(response.body);
    List<NewsCardModel> news = newsJson
        .map((json) => NewsCardModel.fromJson(json as Map<String, dynamic>))
        .toList();
    //debugPrint("News: ${news.toString()}");
    return news;
  }
  return [];
}

  Future<NewsModel> getNewsById(String id) async {
    final token = await storage.read(key: "accessToken");
    final response = await http.get(
      Uri.parse('$baseUrl/news/get/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    //print(response.body);
    NewsModel news = NewsModel.fromJson(json.decode(response.body));
    return news;
  }

  Future<void> createNews(NewsSendModel news) async {
    final token = await storage.read(key: "accessToken");
    final response = await http.post(
      Uri.parse('$baseUrl/news/create-post'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(news.toJson()),
    );
   // print(response.body);
}
 static const String commentUrl = 'http://10.0.2.2:8000/api/v1/comments';
 Future<void> createComment(String newsId , String comment) async {
    final token = await storage.read(key: "accessToken");
    final response = await http.post(
      Uri.parse('$commentUrl/create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'newsId': newsId,
        'comment': comment
      }),
    );
    //print(response.body);
 }
  Future<List<CommentModel>> getComments(String newsId) async {
    final token = await storage.read(key: "accessToken");
    final response = await http.get(
      Uri.parse('$commentUrl/get/$newsId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    //print(response.body);
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final List<dynamic> commentsJson = json.decode(response.body);
      List<CommentModel> comments = commentsJson
          .map((json) => CommentModel.fromJson(json as Map<String, dynamic>))
          .toList();
      //print("Comments: "+ jsonEncode(comments));
      return comments;
    }
    return [];
  }
  
  Future<void> deleteComment(String commentId) async {
    final token = await storage.read(key:"accessToken");
    final response = await http.delete(
      Uri.parse('$commentUrl/delete/$commentId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
 //   print(response.body);
  }

  Future<void> updateComment(String commentId , String comment) async {
    final token = await storage.read(key: "accessToken");
    final response = await http.put(
      Uri.parse('$commentUrl/update/$commentId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'comment': comment
      }),
    );
    print(response.body);
  }
}