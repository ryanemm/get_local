class AccountDetailsCompany {
  final String id;
  final String email;
  final String password;
  final String companyName;
  final String companyRegistration;
  final String address;
  final String phoneNumber;
  final String tradingAs;
  final String service;
  final String accountType;

  const AccountDetailsCompany(
      this.id,
      this.email,
      this.password,
      this.companyName,
      this.companyRegistration,
      this.address,
      this.phoneNumber,
      this.tradingAs,
      this.service,
      this.accountType);

  AccountDetailsCompany.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        companyName = json['companyName'],
        companyRegistration = json['companyRegistration'],
        address = json['address'],
        phoneNumber = json['phoneNumber'],
        tradingAs = json['tradingAs'],
        service = json['service'],
        password = json['password'],
        accountType = json['accountType'];

  /*factory AccountDetails.fromJson(Map<String, dynamic> jsonData) {
    return AccountDetails(
      id: jsonData['id'],
      email: jsonData['email'],
      name: jsonData['name'],
      tracker_id: jsonData['tracker_id'],
      password: jsonData['password'],
    );
  }*/
}
