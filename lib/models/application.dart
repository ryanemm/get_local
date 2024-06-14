class Application{
  final String? applicationId;
  final String companyId;
  final String? listingId;
  final String? userId;

  Application(
      {required this.listingId,
      required this.applicationId,
      required this.companyId,
      required this.userId
});

  factory Application.fromJson(Map<String, dynamic> jsonData) {
    return Application(

      companyId: jsonData['companyId'],
      applicationId: jsonData['applicationId'],
      listingId: jsonData['listingId'],
      userId: jsonData['userId']
    );
  }
}
