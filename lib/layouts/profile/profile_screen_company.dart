import 'package:flutter/material.dart';

class ProfileScreenCompany extends StatefulWidget {
  final String companyName;
  final String service;
  final String email;
  const ProfileScreenCompany(
      {super.key,
      required this.companyName,
      required this.service,
      required this.email});

  @override
  State<ProfileScreenCompany> createState() => _ProfileScreenCompanyState();
}

class _ProfileScreenCompanyState extends State<ProfileScreenCompany> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
