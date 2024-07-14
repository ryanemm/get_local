import 'dart:convert';

class Application {
  final String? applicationId;
  final String companyId;
  final String? listingId;
  final String? userId;
  String? name;

  Application({
    required this.listingId,
    required this.applicationId,
    required this.companyId,
    required this.userId,
    this.name,
  });

  factory Application.fromJson(Map<String, dynamic> jsonData) {
    return Application(
        companyId: jsonData['companyId'],
        applicationId: jsonData['applicationId'],
        listingId: jsonData['listingId'],
        userId: jsonData['userId'],
        name: jsonData['name']);
  }
}
