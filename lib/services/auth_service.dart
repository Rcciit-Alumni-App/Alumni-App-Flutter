import 'package:flutter/material.dart';
import 'package:frontend/models/UserModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// Reference : https://stackoverflow.com/questions/55785581/socketexception-os-error-connection-refused-errno-111-in-flutter-using-djan
class AuthService {
  static const String baseUrl = 'https://alumni-app-backend-a7b0.onrender.com/api/v1/user/auth';
  //static const String baseUrl = 'http://10.0.2.2:8000/api/v1/user';
  final storage = new FlutterSecureStorage();
  Future<Map<String, dynamic>> signup(String personal_email, String college_email, String college_roll, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'personal_email': personal_email,
        "college_email": college_email,
        "college_roll": college_roll,
        'password': password,
      }),
    );

   
      var token =jsonDecode(response.body)["verificationToken"];
      await storage.write(key: "verificationToken", value: token);
      debugPrint(jsonDecode(response.body)["verificationToken"]);
      return jsonDecode(response.body);
    
  }

  Future<Map<String, dynamic>> verify(String otp) async {
    String? token = await storage.read(key: "verificationToken");
    final response = await http.post(
      Uri.parse('$baseUrl/auth/verify'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "verification_token": token!,
        'otp': otp,
      }),
    );
 
      debugPrint("Response"+response.body);
      await storage.delete(key: "verificationToken");
      var accesstoken =jsonDecode(response.body)["access_token"];
      await storage.write(key: "accessToken", value: accesstoken);
      UserModel? user = await getUserProfile();
      debugPrint(jsonEncode(user));
      await storage.write(key: "user", value: jsonEncode(user));
      return jsonDecode(response.body);
    
  }

  Future<Map<String, dynamic>> login(String personal_email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'personal_mail': personal_email,
        'password': password,
      }),
    );
      debugPrint(jsonDecode(response.body)["access_token"]);
      var accesslogintoken =jsonDecode(response.body)["access_token"];
      await storage.write(key: "accessToken", value: accesslogintoken);
      UserModel? user = await getUserProfile();
      await storage.write(key: "user", value: jsonEncode(user));
      return jsonDecode(response.body);
    
  }

  Future<void> forgotPassword(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/forgot-password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to request password reset');
    }
  }

  Future<void> resetPassword(String token, String newPassword) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reset-password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'token': token,
        'password': newPassword,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to reset password');
    }
  }

  Future<void> logout() async {
    await http.delete(
      Uri.parse('$baseUrl/auth/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${await storage.read(key: "accessToken")}',
      },
    );
    await storage.delete(key: "accessToken");

  }

  Future<void> updateUserProfile(UserModel user) async {
    String? accessToken = await storage.read(key: "accessToken");
    final url = Uri.parse('https://alumni-app-backend-a7b0.onrender.com/api/v1/user/profile/update');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    final body = jsonEncode(user.toJson());

    final response = await http.put(
      url,
      headers: headers,
      body: body,
    );

    debugPrint(response.body);
  }

  Future<UserModel> getUserProfile() async {
    String? accessToken = await storage.read(key: "accessToken");
    print(accessToken);
    final url = Uri.parse('https://alumni-app-backend-a7b0.onrender.com/api/v1/user/profile/details');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    final response = await http.get(url, headers: headers);
    final jsonResponse = json.decode(response.body);
    print(response.body);
    return UserModel.fromJson(jsonResponse);
  }


}
