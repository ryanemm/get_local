class OTPResult {
  final String result;

  OTPResult({
    required this.result,
  });

  factory OTPResult.fromJson(Map<String, dynamic> jsonData) {
    return OTPResult(
      result: jsonData['result']
    );
  }
}
