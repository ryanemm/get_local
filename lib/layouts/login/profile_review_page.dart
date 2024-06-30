import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_local/components/gradient_button.dart';
import 'package:get_local/layouts/login/pre_doc_upload.dart';
import 'package:get_local/models/apllicant_id.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileReviewPage extends StatefulWidget {
  final String email;
  final String password;
  final String name;
  final String surname;
  final String address;
  final String phoneNumber;
  final String dateOfBirth;
  final String job;
  const ProfileReviewPage(
      {super.key,
      required this.email,
      required this.name,
      required this.surname,
      required this.address,
      required this.phoneNumber,
      required this.dateOfBirth,
      required this.job,
      required this.password});

  @override
  State<ProfileReviewPage> createState() => _ProfileReviewPageState();
}

class _ProfileReviewPageState extends State<ProfileReviewPage> {
  String? deviceToken;
  String? applicant_id;

  Future createProfile() async {
    var url = "http://139.144.77.133/getLocalDemo/registerLocal.php";
    var response = await http.post(Uri.parse(url), body: {
      "email": widget.email,
      "password": widget.password,
      "name": widget.name,
      "surname": widget.surname,
      "dateOfBirth": widget.dateOfBirth,
      "address": widget.address,
      "phoneNumber": widget.phoneNumber,
      "job": widget.job,
    });

    // var data = json.decode(response.body);

    if (response.statusCode == 200) {
      print("Profile Created");
      print(response.body);

      List applicant_ids = json.decode(response.body);
      var formatted = applicant_ids
          .map((account) => ApplicantId.fromJson(account))
          .toList();
      applicant_id = formatted[0].id;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("email", widget.email);
      await prefs.setString("name", widget.name);
      await prefs.setString("surname", widget.surname);
    }
    if (response.body.contains("Incorrect")) {
      print("Check you the details and verify they are correct");
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
                              "Name",
                              style: GoogleFonts.montserrat(fontSize: 14),
                            ),
                          ),
                          TableCell(
                              child: Text(
                            widget.name,
                            style: GoogleFonts.montserrat(fontSize: 14),
                          ))
                        ]),
                        TableRow(children: [
                          TableCell(
                            child: Text(
                              "Surname",
                              style: GoogleFonts.montserrat(fontSize: 14),
                            ),
                          ),
                          TableCell(
                              child: Text(
                            widget.surname,
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
                              "Date of Birth",
                              style: GoogleFonts.montserrat(fontSize: 14),
                            ),
                          ),
                          TableCell(
                              child: Text(
                            widget.dateOfBirth,
                            style: GoogleFonts.montserrat(fontSize: 14),
                          ))
                        ]),
                        TableRow(children: [
                          TableCell(
                            child: Text(
                              "Job",
                              style: GoogleFonts.montserrat(fontSize: 14),
                            ),
                          ),
                          TableCell(
                              child: Text(
                            widget.job,
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
                          buttonColor1: const Color.fromARGB(255, 19, 53, 61),
                          buttonColor2:
                              const Color.fromARGB(255, 179, 237, 169),
                          shadowColor: Colors.grey.shade500,
                          offsetX: 4,
                          offsetY: 4,
                          width: 120.00,
                          function: () async {
                            // SharedPreferences prefs =
                            // await SharedPreferences.getInstance();
                            await createProfile();
                            /*await prefs.setString("email", widget.email);
                            await prefs.setString("password", widget.password);
                            await prefs.setString("name", widget.name);
                            await prefs.setString("surname", widget.surname);
                            await prefs.setString("address", widget.address);
                            await prefs.setString(
                                "phoneNumber", widget.phoneNumber);
                            await prefs.setString(
                                "tradingAs", widget.dateOfBirth);
                            await prefs.setString("job", widget.job);
                            await prefs.setString("loggedIn", "true");*/

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PreDocUploadPage(
                                        profileType: "local",
                                        applicantId: applicant_id!)));
                          },
                        ),
                      ],
                    )
                  ],
                ))));
  }
}
