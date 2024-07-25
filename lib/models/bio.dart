class Bio {
  final String companyId;
  final String companyName;
  final String bio;

  Bio({
    required this.companyId,
    required this.companyName,
    required this.bio,
  });

  factory Bio.fromJson(Map<String, dynamic> jsonData) {
    return Bio(
      companyId: jsonData['companyId'],
      companyName: jsonData['companyName'],
      bio: jsonData['bio'],
    );
  }
}
