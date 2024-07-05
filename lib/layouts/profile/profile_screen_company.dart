import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(width: 8),
                Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.grey),
                  child: Icon(Icons.person_2_outlined),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Kosi Connect",
                          style: GoogleFonts.montserrat(
                              color: Color.fromARGB(255, 2, 50, 10),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text(
                      "Filtering Services",
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                Expanded(child: Container()),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "21 Steenkamp Street, Del Jundor",
              style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            ),
            Text(
              "Witbank",
              style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            ),
            Text(
              "Mpumalanga",
              style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }
}
