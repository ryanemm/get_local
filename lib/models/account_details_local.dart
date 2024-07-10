class AccountDetailsLocal {
  final String id;

  final String email;
  final String? password;
  final String name;
  final String surname;
  final String address;
  final String phoneNumber;
  final String dateOfBirth;
  final String job;
  final String accountType;
  final String verified;

  const AccountDetailsLocal(
    this.id,
    this.email,
    this.password,
    this.name,
    this.surname,
    this.address,
    this.phoneNumber,
    this.dateOfBirth,
    this.job,
    this.accountType,
    this.verified,
  );

  AccountDetailsLocal.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        password = json['password'],
        name = json['name'],
        surname = json['surname'],
        address = json['address'],
        phoneNumber = json['phoneNumber'],
        dateOfBirth = json['dateOfBirth'],
        job = json['job'],
        accountType = json['accountType'],
        verified = json['verified'];

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
