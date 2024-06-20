class ApplicantId {
  final String id;

  ApplicantId({
    required this.id,
  });

  factory ApplicantId.fromJson(Map<String, dynamic> jsonData) {
    return ApplicantId(
      id: jsonData['id']
    );
  }
}
