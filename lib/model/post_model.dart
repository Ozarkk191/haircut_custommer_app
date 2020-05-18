import 'package:haircut_delivery/model/request_body_parameters.dart';

class PostModel {
  List<Posts> posts;

  PostModel({this.posts});

  PostModel.fromJson(Map<String, dynamic> json) {
    if (json['posts'] != null) {
      posts = new List<Posts>();
      json['posts'].forEach((v) {
        posts.add(new Posts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.posts != null) {
      data['posts'] = this.posts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Posts {
  int userId;
  int id;
  String title;
  String body;

  Posts({this.userId, this.id, this.title, this.body});

  Posts.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}

class CreatePostParameters extends RequestBodyParameters {
  int userId;
  String title;
  String body;

  CreatePostParameters(this.userId, this.body, this.title);

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'title': title,
        'body': body,
      };
}

class UpdatePostParameters extends RequestBodyParameters {
  int userId;
  String title;
  String body;

  UpdatePostParameters(this.userId, this.body, this.title);

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'title': title,
        'body': body,
      };
}
