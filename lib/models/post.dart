class Post {
  final String company;
  final String? title;
  final String? content;

  Post({
    required this.company,
    required this.title,
    required this.content,
  });

  factory Post.fromJson(Map<String, dynamic> jsonData) {
    return Post(
      company: jsonData['company'],
      title: jsonData['title'],
      content: jsonData['content'],
    );
  }
}
