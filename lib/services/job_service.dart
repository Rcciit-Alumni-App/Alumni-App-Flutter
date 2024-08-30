import 'dart:convert';
//import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/models/JobsModel.dart';
import 'package:http/http.dart' as http;

class JobService {
  static const String baseUrl = 'https://alumni-app-backend-a7b0.onrender.com/api/v1';
  final storage = new FlutterSecureStorage();

 Future<List<JobsCardModel>> getAlljobs() async {
  final token = await storage.read(key: "accessToken");
  final response = await http.get(
    Uri.parse('$baseUrl/opportunities'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200 && response.body.isNotEmpty) {
   // print(response.body);
    final List<dynamic> jobsJson = json.decode(response.body);
    List<JobsCardModel> jobs = jobsJson
        .map((json) => JobsCardModel.fromJson(json as Map<String, dynamic>))
        .toList();
    //debugPrint("Jobs: ${jobs.toString()}");
    return jobs;
  }
  return [];
}

  Future<JobModel> getJobsById(String id) async {
    final token = await storage.read(key: "accessToken");
    final response = await http.get(
      Uri.parse('$baseUrl/opportunities/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    //print(response.body);
    JobModel job = JobModel.fromJson(json.decode(response.body));
    return job;
  }


}
