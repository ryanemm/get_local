import 'dart:convert';

class Post {
  final String id;
  final String company;
  final String? title;
  final String? content;

  Post({
    required this.id,
    required this.company,
    required this.title,
    required this.content,
  });

  factory Post.fromJson(Map<String, dynamic> jsonData) {
    return Post(
      id: jsonData['id'],
      company: jsonData['company'],
      title: jsonData['title'],
      content: jsonData['content'],
    );
  }
}
