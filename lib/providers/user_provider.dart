import 'package:flutter/material.dart';
import 'package:frontend/models/UserModel.dart';
import 'package:provider/provider.dart'; 

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  Future<void> loadUserData() async {
    await Future.delayed(Duration(seconds: 2)); 
    final fetchedData = {
      'full_name': 'John Doe',
      'phone': '1234567890',
      'personal_mail': 'john.doe@example.com',
      'college_mail': 'johndoe@college.edu',
      'university_roll': '20240123',
      'profile_pic_url': 'http://example.com/profile.jpg',
      'higher_studies': [
        {
          'id': 1,
          'institute': 'Some Institute',
          'course': 'Computer Science',
          'start_date': '2021-08-01T00:00:00.000Z',
          'end_date': '2024-05-31T00:00:00.000Z',
        },
      ],
      'internships': [
        {
          'id': 1,
          'company': 'Tech Company',
          'role': 'Intern',
          'start_date': '2023-06-01T00:00:00.000Z',
          'end_date': '2023-08-31T00:00:00.000Z',
          'skills': ['Flutter', 'Firebase'],
        },
      ],
    };

    _user = UserModel.fromJson(fetchedData);
    notifyListeners();
  }
  void updateUser(UserModel updatedUser) {
    _user = updatedUser;
    notifyListeners();
  }
}

