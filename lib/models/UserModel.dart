
class HigherStudies {
  final int? id;
  final String? institute;
  final String? course;
  final DateTime? startDate;
  final DateTime? endDate;

  HigherStudies({
    required this.id,
    required this.institute,
    required this.course,
    required this.startDate,
    required this.endDate,
  });

  factory HigherStudies.fromJson(Map<String, dynamic> json) {
    return HigherStudies(
      id: json['id'],
      institute: json['institute'],
      course: json['course'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'institute': institute,
      'course': course,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
    };
  }
}

class Internship {
  final int? id;
  final String? company;
  final String? role;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<String>? skills;

  Internship({
    required this.id,
    required this.company,
    required this.role,
    required this.startDate,
    required this.endDate,
    required this.skills,
  });

  factory Internship.fromJson(Map<String, dynamic> json) {
    return Internship(
      id: json['id'],
      company: json['company'],
      role: json['role'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      skills: List<String>.from(json['skills']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company,
      'role': role,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'skills': skills,
    };
  }
}

class UserModel {
  final String? fullName;
  final String? phone;
  final String? personalMail;
  final String? collegeMail;
  final String? universityRoll;
  final String? profilePicUrl;
  final List<HigherStudies>? higherStudies;
  final List<Internship>? internships;

  UserModel({
    required this.fullName,
    required this.phone,
    required this.personalMail,
    required this.collegeMail,
    required this.universityRoll,
    required this.profilePicUrl,
    required this.higherStudies,
    required this.internships,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['full_name'],
      phone: json['phone'],
      personalMail: json['personal_mail'],
      collegeMail: json['college_mail'],
      universityRoll: json['university_roll'],
      profilePicUrl: json['profile_pic_url'],
      higherStudies: (json['higher_studies'] as List)
          .map((i) => HigherStudies.fromJson(i))
          .toList(),
      internships: (json['internships'] as List)
          .map((i) => Internship.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'phone': phone,
      'personal_mail': personalMail,
      'college_mail': collegeMail,
      'university_roll': universityRoll,
      'profile_pic_url': profilePicUrl,
      'higher_studies': higherStudies?.map((e) => e.toJson()).toList(),
      'internships': internships?.map((e) => e.toJson()).toList(),
    };
  }
}
