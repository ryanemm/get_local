import 'dart:convert';

class Listing {
  final String? id;
  final String company;
  final String companyId;
  final String? job;
  final String? startDate;
  final String? endDate;
  final String? applications;
  final String? timeStamp;
  final String? interviewDateTime;

  Listing(
      {required this.id,
      required this.company,
      required this.companyId,
      required this.job,
      required this.startDate,
      required this.endDate,
      this.timeStamp,
      this.interviewDateTime,
      required this.applications});

  factory Listing.fromJson(Map<String, dynamic> jsonData) {
    return Listing(
        id: jsonData['id'],
        company: jsonData['company'],
        companyId: jsonData['companyId'],
        job: jsonData['job'],
        startDate: jsonData['startDate'],
        endDate: jsonData['endDate'],
        applications: jsonData['applications'],
        timeStamp: jsonData['timestamp'],
        interviewDateTime: jsonData['interviewDateTime']);
  }
}
