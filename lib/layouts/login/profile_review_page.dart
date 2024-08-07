import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get_local/components/gradient_button.dart';
import 'package:get_local/layouts/login/pre_doc_upload.dart';
import 'package:get_local/models/apllicant_id.dart';
import 'package:get_local/widgets/widgets.dart';
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
  final String accountType;
  const ProfileReviewPage(
      {super.key,
      required this.email,
      required this.name,
      required this.surname,
      required this.address,
      required this.phoneNumber,
      required this.dateOfBirth,
      required this.job,
      required this.password,
      required this.accountType});

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
      await prefs.setString("password", widget.password);
      await prefs.setString("name", widget.name);
      await prefs.setString("surname", widget.surname);
      await prefs.setString("job", widget.job);
      await prefs.setString("loggedIn", "true");
      await prefs.setString("accountType", "local");
      await prefs.setString("approved", "false");
      await prefs.setString("id", applicant_id!);
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
                    Expanded(
                      child: Container(),
                    ),
                    Text(
                        "Please review your details and confirm they are correct.",
                        style: GoogleFonts.montserrat(
                            fontSize: 16, fontWeight: FontWeight.bold)),
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
                    Expanded(child: Container()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GradientButton(
                          text: "Confirm",
                          buttonColor1: Color.fromARGB(255, 253, 228, 0),
                          buttonColor2: Color.fromARGB(255, 194, 176, 9),
                          textColor: const Color.fromARGB(255, 19, 53, 61),
                          shadowColor: Colors.grey.shade500,
                          offsetX: 4,
                          offsetY: 4,
                          width: 120.00,
                          function: () async {
                            await createProfile();

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PreDocUploadPage(
                                        profileType: "local",
                                        applicantId: applicant_id!,
                                        accountType: widget.accountType,
                                        name: widget.name,
                                        surname: widget.surname,
                                        email: widget.email,
                                        job: widget.job,
                                        password: widget.password,
                                        approved: "false")));
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 64,
                    )
                  ],
                ))));
  }
}
