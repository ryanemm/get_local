import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_local/components/gradient_button.dart';
import 'package:get_local/layouts/login/pre_doc_upload.dart';
import 'package:get_local/models/account_details_company.dart';
import 'package:get_local/models/apllicant_id.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileReviewPageCompany extends StatefulWidget {
  final String email;
  final String password;
  final String companyName;
  final String companyRegistration;
  final String address;
  final String phoneNumber;
  final String tradingAs;
  final String service;
  final String accountType;
  const ProfileReviewPageCompany(
      {super.key,
      required this.email,
      required this.companyName,
      required this.companyRegistration,
      required this.address,
      required this.phoneNumber,
      required this.tradingAs,
      required this.service,
      required this.password,
      required this.accountType});

  @override
  State<ProfileReviewPageCompany> createState() =>
      _ProfileReviewPageCompanyState();
}

class _ProfileReviewPageCompanyState extends State<ProfileReviewPageCompany> {
  String? deviceToken;
  String? applicant_id;

  Future createProfile() async {
    print("creating profile");
    var url = "http://139.144.77.133/getLocalDemo/registerCompany.php";
    var response = await http.post(Uri.parse(url), body: {
      "email": widget.email,
      "password": widget.password,
      "companyName": widget.companyName,
      "companyRegistration": widget.companyRegistration,
      "address": widget.address,
      "phoneNumber": widget.phoneNumber,
      "tradingAs": widget.tradingAs,
      "service": widget.service
    });

    var data = json.decode(response.body);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      print("Profile Created");
      print(response.body);
      List accountDetails = json.decode(response.body);
      var formatted = accountDetails
          .map((account) => AccountDetailsCompany.fromJson(account))
          .toList();
      applicant_id = formatted[0].id;
    }
    if (response.body.contains("Incorrect")) {
      print("Check your the details and verify they are correct");
    }

    /*if (data == "Login Successful.") {
      Fluttertoast.showToast(msg: "Login successful");
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoard(),),);
    } else {
      /*FlutterToast(context).showToast(
          child: Text('Username and password invalid',
              style: TextStyle(fontSize: 25, color: Colors.red)));*/
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[50],
            ),
            body: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                height: double.infinity,
                color: Colors.grey[50],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        "Please review your details and confirm they are correct.",
                        style: GoogleFonts.montserrat(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    SizedBox(height: 32),
                    Table(
                      children: [
                        TableRow(children: [
                          TableCell(
                            child: Text(
                              "Email",
                              style: GoogleFonts.montserrat(fontSize: 14),
                            ),
                          ),
                          TableCell(
                              child: Text(
                            widget.email,
                            style: GoogleFonts.montserrat(fontSize: 14),
                          ))
                        ]),
                        TableRow(children: [
                          TableCell(
                            child: Text(
                              "Company Name",
                              style: GoogleFonts.montserrat(fontSize: 14),
                            ),
                          ),
                          TableCell(
                              child: Text(
                            widget.companyName,
                            style: GoogleFonts.montserrat(fontSize: 14),
                          ))
                        ]),
                        TableRow(children: [
                          TableCell(
                            child: Text(
                              "Trading As",
                              style: GoogleFonts.montserrat(fontSize: 14),
                            ),
                          ),
                          TableCell(
                              child: Text(
                            widget.tradingAs,
                            style: GoogleFonts.montserrat(fontSize: 14),
                          ))
                        ]),
                        TableRow(children: [
                          TableCell(
                            child: Text(
                              "Address",
                              style: GoogleFonts.montserrat(fontSize: 14),
                            ),
                          ),
                          TableCell(
                              child: Text(
                            widget.address,
                            style: GoogleFonts.montserrat(fontSize: 14),
                          ))
                        ]),
                        TableRow(children: [
                          TableCell(
                            child: Text(
                              "Phone Number",
                              style: GoogleFonts.montserrat(fontSize: 14),
                            ),
                          ),
                          TableCell(
                              child: Text(
                            widget.phoneNumber,
                            style: GoogleFonts.montserrat(fontSize: 14),
                          ))
                        ]),
                        TableRow(children: [
                          TableCell(
                            child: Text(
                              "Company Registration",
                              style: GoogleFonts.montserrat(fontSize: 14),
                            ),
                          ),
                          TableCell(
                              child: Text(
                            widget.companyRegistration,
                            style: GoogleFonts.montserrat(fontSize: 14),
                          ))
                        ]),
                        TableRow(children: [
                          TableCell(
                            child: Text(
                              "Service",
                              style: GoogleFonts.montserrat(fontSize: 14),
                            ),
                          ),
                          TableCell(
                              child: Text(
                            widget.service,
                            style: GoogleFonts.montserrat(fontSize: 14),
                          ))
                        ]),
                      ],
                    ),
                    SizedBox(height: 64),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GradientButton(
                          text: "Confirm",
                          buttonColor1: Color.fromARGB(255, 10, 36, 114),
                          buttonColor2: Color.fromARGB(255, 135, 226, 242),
                          shadowColor: Colors.grey.shade500,
                          offsetX: 4,
                          offsetY: 4,
                          width: 120.00,
                          function: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await createProfile();
                            await prefs.setString("email", widget.email);
                            await prefs.setString("password", widget.password);
                            await prefs.setString(
                                "companyName", widget.companyName);
                            await prefs.setString("companyRegistration",
                                widget.companyRegistration);
                            await prefs.setString("address", widget.address);
                            await prefs.setString(
                                "phoneNumber", widget.phoneNumber);
                            await prefs.setString(
                                "tradingAs", widget.tradingAs);
                            await prefs.setString("service", widget.service);
                            await prefs.setString("loggedIn", "true");

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PreDocUploadPage(
                                          profileType: "company",
                                          applicantId: applicant_id!,
                                          accountType: widget.accountType,
                                        )));
                          },
                        ),
                      ],
                    )
                  ],
                ))));
    ;
  }
}
