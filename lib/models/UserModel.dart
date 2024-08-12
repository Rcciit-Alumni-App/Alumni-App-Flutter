import 'dart:convert';

class HigherStudy {
  int? id;
  String? institute;
  String? course;
  DateTime? startDate;
  DateTime? endDate;

  HigherStudy({
    this.id,
    this.institute,
    this.course,
    this.startDate,
    this.endDate,
  });

  factory HigherStudy.fromJson(Map<String, dynamic> json) {
    return HigherStudy(
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
      'start_date': startDate == null ? startDate : startDate!.toIso8601String(),
      'end_date': endDate == null ? endDate : endDate!.toIso8601String(),
    };
  }
}

class Internship {
  int? id;
  String? company;
  String? domain;
  String? role;
  DateTime? startDate;
  DateTime? endDate;
  List<String?>? skills;
  String? description;

  Internship({
    this.id,
    this.company,
    this.role,
    this.startDate,
    this.endDate,
    this.skills,
    this.description,
    this.domain
  });

  factory Internship.fromJson(Map<String, dynamic> json) {
    return Internship(
      id: json['id'],
      company: json['company'],
      role: json['role'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      skills: List<String>.from(json['skills']),
      description: json['description'],
      domain: json['domain']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company,
      'role': role,
      'start_date': startDate == null ? startDate : startDate!.toIso8601String(),
      'end_date': endDate == null ? endDate : endDate!.toIso8601String(),
      'skills': skills,
      'description': description,
      'domain': domain
    };
  }
}

class WorkExperience {
  int? id;
  String? company;
  String? domain;
  String? role;
  DateTime? startDate;
  DateTime? endDate;
  List<String?>? skills;
  String? description;

  WorkExperience({
    this.id,
    this.company,
    this.role,
    this.startDate,
    this.endDate,
    this.skills,
    this.description,
    this.domain
  });

  factory WorkExperience.fromJson(Map<String, dynamic> json) {
    return WorkExperience(
      id: json['id'],
      company: json['company'],
      role: json['role'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      skills: List<String>.from(json['skills']),
      description: json['description'],
      domain: json['domain']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company,
      'role': role,
      'start_date': startDate == null ? startDate : startDate!.toIso8601String(),
      'end_date': endDate == null ? endDate : endDate!.toIso8601String(),
      'skills': skills,
      'description': description,
      'domain': domain
    };
  }
}

class UserModel {
  String fullName;
  String phone;
  String personalMail;
  String collegeMail;
  String password;
  String collegeRoll;
  String universityRoll;
  String profilePicUrl;
  String userType;
  String stream;
  String status;
  List<String> domains;
  List<String> socials;
  List<HigherStudy> higherStudies;
  List<Internship> internships;
  List<WorkExperience> workExperiences;

  UserModel({
    required this.fullName,
    required this.phone,
    required this.personalMail,
    required this.collegeMail,
    required this.password,
    required this.collegeRoll,
    required this.universityRoll,
    required this.profilePicUrl,
    required this.userType,
    required this.stream,
    required this.status,
    required this.higherStudies,
    required this.internships,
    required this.workExperiences,
    required this.domains,
    required this.socials,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['full_name'] ?? '',
      phone: json['phone'] ?? '',
      personalMail: json['personal_mail'] ?? '',
      collegeMail: json['college_mail'] ?? '',
      password: json['password'] ?? '',
      collegeRoll: json['college_roll'] ?? '',
      universityRoll: json['university_roll'] ?? '',
      profilePicUrl: json['profile_pic_url'] ?? '',
      userType: json['user_type'] ?? '',
      stream: json['stream'] ?? '',
      status: json['status'] ?? '',
      socials: json['socials'] ?? '',
      domains: json['domains'] ?? '',
      higherStudies: (json['higher_studies'] as List? ?? []).map((item) => HigherStudy.fromJson(item)).toList(),
      internships: (json['internships'] as List? ?? []).map((item) => Internship.fromJson(item)).toList(),
      workExperiences: (json['work_experiences'] as List? ?? []).map((item) => WorkExperience.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'phone': phone,
      'personal_mail': personalMail,
      'college_mail': collegeMail,
      'password': password,
      'college_roll': collegeRoll,
      'university_roll': universityRoll,
      'profile_pic_url': profilePicUrl,
      'user_type': userType,
      'stream': stream,
      'status': status,
      'higher_studies': higherStudies.map((item) => item.toJson()).toList(),
      'internships': internships.map((item) => item.toJson()).toList(),
      'work_experiences': workExperiences.map((item) => item.toJson()).toList(),
    };
  }
}
