//  {
//     "id": "66c1d41e904bdb53b8009f3b",
//     "category_id": "66c1d3f6e5a5b098f26c0d0d",
//     "created_by": "66bba20d934d8024078fd894",
//     "title": "Junior Software Engineer",
//     "company_name": "Innovate Tech",
//     "description": "Work on exciting projects in a fast-paced environment.",
//     "apply_link": "https://innovate-tech.com/careers",
//     "location": "San Francisco, CA",
//     "job_type": "JOB",
//     "posted_at": "2024-08-18T10:59:39.222Z",
//     "application_deadline": "2024-09-01T23:59:59.000Z"
//   },

class JobsCardModel{
  final String id;
  final String category_id;
  final String created_by;
  final String title;
  final String company_name;
  final String description;
  final String apply_link;
  final String location;
  final String job_type;
  final DateTime posted_at;
  final DateTime application_deadline;

  JobsCardModel({
    required this.id,
    required this.category_id,
    required this.created_by,
    required this.title,
    required this.company_name,
    required this.description,
    required this.apply_link,
    required this.location,
    required this.job_type,
    required this.posted_at,
    required this.application_deadline,
  });

  factory JobsCardModel.fromJson(Map<String, dynamic> json){
    return JobsCardModel(
      id: json['id'] ?? "",
      category_id: json['category_id'] ?? "",
      created_by: json['created_by'] ?? "",
      title: json['title'] ?? "",
      company_name: json['company_name'] ?? "",
      description: json['description'] ?? "",
      apply_link: json['apply_link'] ?? "",
      location: json['location'] ?? "",
      job_type: json['job_type'] ?? "",
      posted_at: DateTime.parse(json['posted_at']),
      application_deadline: DateTime.parse(json['application_deadline'])
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': category_id,
      'created_by': created_by,
      'title': title,
      'company_name': company_name,
      'description': description,
      'apply_link': apply_link,
      'location': location,
      'job_type': job_type,
      'posted_at': posted_at.toIso8601String(),
      'application_deadline': application_deadline.toIso8601String()
    };
  }
}