import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class FileServices {
  static const String baseUrl = 'http://10.0.2.2:8000/api/v1/user';

  Future<dynamic> uploadCsvFile(String filePath) async {
    if (!filePath.endsWith('.csv')) {
      return;
    }

    final storage = new FlutterSecureStorage();

    String? token = await storage.read(key: "accessToken");

    if (token == null) return;

    final Uri url = Uri.parse('$baseUrl/auth/create-users');

    try {
      String? mimeType = lookupMimeType(filePath);

      if (mimeType == null || mimeType != 'text/csv') {
        throw Exception('The file must be a CSV.');
      }

      File file = File(filePath);
      if (await file.length() > 10 * 1024 * 1024) {
        throw Exception('The file size must be up to 10 MB.');
      }

      var request = http.MultipartRequest('POST', url);

      request.headers['Authorization'] = 'Bearer $token';

      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          filePath,
          contentType: MediaType.parse(mimeType),
        ),
      );

      var response = await request.send();

      if (response.statusCode == 201) {
        print('User created successfully.');
        return response;
      } else if (response.statusCode == 400) {
        throw('Bad request. Possibly due to invalid file or file size exceeding limit.');
      } else {
        throw('Failed to create user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw('Error: $e');
    }
  }
}
