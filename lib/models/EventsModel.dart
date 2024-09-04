

import 'package:frontend/models/UserModel.dart';

class EventInterests {
  String id;
  String userId;
  UserModel? user;
  String eventId;
  Eventsmodel event;
  DateTime expiresAt;

  EventInterests(
      {required this.id,
      required this.userId,
      this.user,
      required this.eventId,
      required this.event,
      required this.expiresAt});

  factory EventInterests.fromJson(Map<String, dynamic> json) {
    return EventInterests(
        id: json['id'],
        userId: json['userId'],
        user: UserModel.fromJson(json['user']),
        eventId: json['eventId'],
        event: Eventsmodel.fromJson(json['event']),
        expiresAt: DateTime.parse(json['expiresAt']));
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'user': user?.toJson(),
        'eventId': eventId,
        'event': event.toJson(),
        'expiresAt': expiresAt.toIso8601String()
      };
}
// {
//   "id": "66c0a051ce5e1816793b866a",
//   "venue": "Grand Ballroom, New York",
//   "schedule": "07:00 PM - Dinner Served",
//   "banner_image": "https://example.com/charity-gala-banner.jpg",
//   "images": [
//     "https://example.com/gala-image1.jpg",
//     "https://example.com/gala-image2.jpg"
//   ],
//   "announcements": {
//     "title": "Donation Matching",
//     "description": "All donations will be matched dollar for dollar!"
//   },
//   "event_name": "Annual Charity Gala",
//   "rules": [
//     "Formal attire required",
//     "No photography during the auction"
//   ],
//   "description": [
//     "Dinner and silent auction",
//     "Guest speeches and awards",
//     "Fundraising activities"
//   ],
//   "attractions": {
//     "label": "Special Guest",
//     "value": "celebrity-guest"
//   },
//   "eventInterests": [],
//   "created_at": "2024-08-17T13:06:20.818Z"
// }
class Eventsmodel {
  String id;
  String eventName;
  String bannerImage;
  String venue;
  List<String> description;
  List<String> images;
  String schedule;
  EventAttraction attractions;
  List<String> rules;
  EventAnnouncement announcements;
  List<EventInterests>? eventInterests;
  DateTime createdAt;


  Eventsmodel(
      {required this.id,
      required this.eventName,
      required this.bannerImage,
      required this.venue,
      required this.description,
      required this.images,
      required this.schedule,
      required this.attractions,
      required this.rules,
      required this.announcements,
      required this.eventInterests,
      required this.createdAt,
});

  factory Eventsmodel.fromJson(Map<String, dynamic> json) {
    return Eventsmodel(
        id: json['id'] ?? '',
        eventName: json['event_name'] ?? '',
        bannerImage: json['banner_image'] ?? '',
        venue: json['venue'] ?? '',
        description: List<String>.from(json['description']),
        images: List<String>.from(json['images']),
        schedule: json['schedule'] ?? '',
        attractions: EventAttraction.fromJson(json['attractions']),
        rules: List<String>.from(json['rules']),
        announcements: EventAnnouncement.fromJson(json['announcements']),
        eventInterests: (json['eventInterests'] as List? ?? []).map((item) => EventInterests.fromJson(item)).toList(),
        createdAt: DateTime.parse(json['created_at']),);
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'event_name': eventName,
        'banner_image': bannerImage,
        'venue': venue,
        'description': description,
        'images': images,
        'schedule': schedule,
        'attractions': attractions.toJson(),
        'rules': rules,
        'announcements': announcements.toJson(),
        'eventInterests': eventInterests?.map((e) => e.toJson()).toList(),
        'created_at': createdAt.toIso8601String(),
      };
}

class EventAttraction {
  String label;
  String value;

  EventAttraction({required this.label, required this.value});

  factory EventAttraction.fromJson(Map<String, dynamic> json) {
    return EventAttraction(label: json['label'], value: json['value']);
  }
  Map<String, dynamic> toJson() => {'label': label, 'value': value};
}

class EventAnnouncement {
  String title;
  String description;

  EventAnnouncement({required this.title, required this.description});

  factory EventAnnouncement.fromJson(Map<String, dynamic> json) {
    return EventAnnouncement(
        title: json['title'], description: json['description']);
  }
  Map<String, dynamic> toJson() => {'title': title, 'description': description};
}

class EventsCardmodel {
  String id;
  String eventName;
  String bannerImage;
  List<String> description;
  String schedule;

  EventsCardmodel({
    required this.id,
    required this.eventName,
    required this.bannerImage,
    required this.description,
    required this.schedule,
  });

  factory EventsCardmodel.fromJson(Map<String, dynamic> json) {
    return EventsCardmodel(
      id: json['id'],
      eventName: json['event_name'],
      bannerImage: json['banner_image'],
      description: List<String>.from(json['description']),
      schedule: json['schedule'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'event_name': eventName,
        'banner_image': bannerImage,
        'description': description,
        'schedule': schedule,
      };
}
