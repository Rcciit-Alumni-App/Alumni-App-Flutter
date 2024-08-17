import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/models/NewsModel.dart';
import 'package:http/http.dart' as http;

class NewsService {
  static const String baseUrl = 'http://10.0.2.2:8000/api/v1';
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
    debugPrint("News: ${news.toString()}");
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
    print(response.body);
    NewsModel news = NewsModel.fromJson(json.decode(response.body));
    return news;
  }


}
