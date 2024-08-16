// model News {
//   id          String        @id @default(auto()) @map("_id") @db.ObjectId
//   author_id   String        @db.ObjectId
//   author      User          @relation(fields: [author_id], references: [id], onDelete: Cascade)
//   title       String
//   description String
//   banner      String
//   tags        String[]
//   activities  NewsActivity?
//   comment     Comment[]

//   created_at DateTime @default(now())
//   updated_at DateTime @updatedAt
// }

// model Comment {
//   id     String @id @default(auto()) @map("_id") @db.ObjectId
//   userId String @db.ObjectId
//   user   User   @relation(fields: [userId], references: [id], onDelete: Cascade)

//   newsId String @db.ObjectId
//   news   News   @relation(fields: [newsId], references: [id], onDelete: Cascade)

//   comment    String
//   isEdited   Boolean
  
//   created_at DateTime @default(now())
//   updated_at DateTime @updatedAt
// }

import 'package:frontend/models/UserModel.dart';

class CommentModel{
  String id;
  String userId;
  UserModel user;
  String newsId;
  NewsModel news;
  String comment;
  bool isEdited;
  DateTime created_at;
  DateTime updated_at;

  CommentModel({
    required this.id,
    required this.userId,
    required this.user,
    required this.newsId,
    required this.news,
    required this.comment,
    required this.isEdited,
    required this.created_at,
    required this.updated_at
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] ?? "",
      userId: json['userId'] ?? "",
      user: UserModel.fromJson(json['user']),
      newsId: json['newsId'] ?? "",
      news: NewsModel.fromJson(json['news']),
      comment: json['comment'] ?? "",
      isEdited: json['isEdited'] ?? false,
      created_at: DateTime.parse(json['created_at']),
      updated_at: DateTime.parse(json['updated_at'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'user': user.toJson(),
      'newsId': newsId,
      'news': news.toJson(),
      'comment': comment,
      'isEdited': isEdited,
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String()
    };
  }
}

class NewsActivityModel{
  int likes;
  int comments;

  NewsActivityModel({
    required this.likes,
    required this.comments
  });

  factory NewsActivityModel.fromJson(Map<String, dynamic> json) {
    return NewsActivityModel(
      likes: json['likes'] ?? 0,
      comments: json['comments'] ?? 0
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'likes': likes,
      'comments': comments
    };
  }
}

class NewsModel{
  String id;
  String author_id;
  UserModel? author;
  String title;
  String description;
  String banner;
  List<String> tags;
  List<CommentModel> comment;
  NewsActivityModel activities;
  DateTime created_at;
  DateTime updated_at;

  NewsModel({
    required this.id,
    required this.author_id,
    this.author,
    required this.title,
    required this.description,
    required this.banner,
    required this.tags,
    required this.comment,
    required this.activities,
    required this.created_at,
    required this.updated_at
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] ?? "",
      author_id: json['author_id'] ?? "",
      author: UserModel.fromJson(json['author']),
      title: json['title'],
      description: json['description'] ?? "",
      banner: json['banner'] ?? "",
      tags: List<String>.from(json['tags']),
      comment: List<CommentModel>.from(json['comment'].map((x) => CommentModel.fromJson(x))),
      activities: NewsActivityModel.fromJson(json['activities']),
      created_at: DateTime.parse(json['created_at']),
      updated_at: DateTime.parse(json['updated_at'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author_id': author_id,
      'author': author?.toJson(),
      'title': title,
      'description': description,
      'banner': banner,
      'tags': tags,
      'comment': comment,
      'activities': activities.toJson(),
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String()
    };
  }
}

class NewsCardModel{
  String id;
  String author_id;
  String title;
  String description;
  String banner;
  List<String> tags;
  NewsActivityModel activities;
  DateTime created_at;
  DateTime updated_at;

  NewsCardModel({
    required this.id,
    required this.author_id,
    required this.title,
    required this.description,
    required this.banner,
    required this.tags,
    required this.activities,
    required this.created_at,
    required this.updated_at
  });

  factory NewsCardModel.fromJson(Map<String, dynamic> json) {
    return NewsCardModel(
      id: json['id'] ?? "",
      author_id: json['author_id'] ?? "",
      title: json['title'],
      description: json['description'] ?? "",
      banner: json['banner'] ?? "",
      tags: List<String>.from(json['tags']),
      activities: NewsActivityModel.fromJson(json['activities']),
      created_at: DateTime.parse(json['created_at']),
      updated_at: DateTime.parse(json['updated_at'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author_id': author_id,
      'title': title,
      'description': description,
      'banner': banner,
      'tags': tags,
      'activities': activities.toJson(),
      'created_at': created_at.toIso8601String(),
      'updated_at': updated_at.toIso8601String()
    };
  }
}