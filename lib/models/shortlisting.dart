import 'dart:convert';

class Shortlisting {
  final String listingId;
  final String userId;
  final String name;
  final String surname;

  Shortlisting(
      {required this.listingId,
      required this.userId,
      required this.name,
      required this.surname});

  factory Shortlisting.fromJson(Map<String, dynamic> jsonData) {
    return Shortlisting(
        listingId: jsonData['listing_id'],
        userId: jsonData['user_id'],
        name: jsonData['name'],
        surname: jsonData['surname']);
  }
}
