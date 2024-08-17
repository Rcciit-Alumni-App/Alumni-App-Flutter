// type EventAttraction {
//   label String
//   value String
// }

// type EventAnnouncements {
//   title       String
//   description String
// }

// model Events {
//   id     String @id @default(auto()) @map("_id") @db.ObjectId
//   userId String @db.ObjectId
//   user   User   @relation(fields: [userId], references: [id], onDelete: Cascade)

//   event_image    String
//   banner_image   String
//   venue          String
//   description    String[]
//   images         String[]
//   schedule       String
//   attractions    EventAttraction
//   rules          String[]
//   announcements  EventAnnouncements
//   eventInterests EventInterests[]
//   expires_at     DateTime

//   created_at DateTime @default(now())
//   updated_at DateTime @updatedAt
// }

// model EventInterests {
//   id        String   @id @default(auto()) @map("_id") @db.ObjectId
//   userId    String   @unique @db.ObjectId
//   user      User     @relation(fields: [userId], references: [id], onDelete: Cascade)
//   eventId   String   @unique @db.ObjectId
//   event     Events   @relation(fields: [eventId], references: [id], onDelete: Cascade)
//   expiresAt DateTime
// }

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
        'expiresAt': expiresAt.toString()
      };
}

class Eventsmodel {
  String id;
  String userId;
  UserModel? user;
  String eventName;
  String bannerImage;
  String venue;
  List<String> description;
  List<String> images;
  String schedule;
  EventAttraction attractions;
  List<String> rules;
  EventAnnouncement announcements;
  List<EventInterests> eventInterests;
  DateTime expiresAt;
  DateTime createdAt;
  DateTime updatedAt;

  Eventsmodel(
      {required this.id,
      required this.userId,
      required this.user,
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
      required this.expiresAt,
      required this.createdAt,
      required this.updatedAt});

  factory Eventsmodel.fromJson(Map<String, dynamic> json) {
    return Eventsmodel(
        id: json['id'] ?? '',
        userId: json['userId'] ?? '',
        user: UserModel.fromJson(json['user']) ,
        eventName: json['event_name'] ?? '',
        bannerImage: json['banner_image'] ?? '',
        venue: json['venue'] ?? '',
        description: List<String>.from(json['description']),
        images: List<String>.from(json['images']),
        schedule: json['schedule'] ?? '',
        attractions: EventAttraction.fromJson(json['attractions']),
        rules: List<String>.from(json['rules']),
        announcements: EventAnnouncement.fromJson(json['announcements']),
        eventInterests: List<EventInterests>.from(json['eventInterests']),
        expiresAt: DateTime.parse(json['expires_at']),
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']));
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'user': user?.toJson(),
        'event_name': eventName,
        'banner_image': bannerImage,
        'venue': venue,
        'description': description,
        'images': images,
        'schedule': schedule,
        'attractions': attractions.toJson(),
        'rules': rules,
        'announcements': announcements.toJson(),
        'eventInterests': eventInterests.map((e) => e.toJson()).toList(),
        'expires_at': expiresAt.toString(),
        'created_at': createdAt.toString(),
        'updated_at': updatedAt.toString()
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
