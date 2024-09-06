import 'dart:convert';
// import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/models/EventsModel.dart';
import 'package:http/http.dart' as http;

class EventService {
  //static const String baseUrl = 'https://alumni-app-backend-a7b0.onrender.com/api/v1';
  static const String baseUrl = 'http://10.0.2.2:8000/api/v1';
  final storage = new FlutterSecureStorage();

 Future<List<EventsCardmodel>> getAllEvents() async {
  final token = await storage.read(key: "accessToken");
  final response = await http.get(
    Uri.parse('$baseUrl/events/get-all'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200 && response.body.isNotEmpty) {
    final List<dynamic> eventsJson = json.decode(response.body);
    List<EventsCardmodel> events = eventsJson
        .map((json) => EventsCardmodel.fromJson(json as Map<String, dynamic>))
        .toList();
    //print("Events: ${events.toString()}");
    return events;
  }
  return [];
}

  Future<Eventsmodel> getEventsById(String id) async {
    final token = await storage.read(key: "accessToken");
    final response = await http.get(
      Uri.parse('$baseUrl/events/get/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    //print("Response"+response.body);
    
    Eventsmodel event = Eventsmodel.fromJson(json.decode(response.body));
    //debugPrint("Response"+response.body);
    return event;
  
  }

  Future<bool> createInterest(String eventId) async {
    final token = await storage.read(key: "accessToken");
    final response = await http.post(
      Uri.parse('$baseUrl/events/interest'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'eventId': eventId,
      }),
    );
    return response.statusCode == 200;
  }

}
