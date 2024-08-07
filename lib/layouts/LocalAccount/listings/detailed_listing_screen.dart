import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_local/components/gradient_button.dart';
import 'package:get_local/components/image_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' show post;

class DetailedListingScreen extends StatefulWidget {
  final String id;
  final String company;
  final String companyId;
  final String? job;
  final String? startDate;
  final String? endDate;
  final String approved;
  final String applicantName;
  final String applicantSurname;
  final String userId;
  const DetailedListingScreen(
      {super.key,
      required this.id,
      required this.company,
      required this.companyId,
      this.job,
      this.startDate,
      this.endDate,
      required this.approved,
      required this.applicantName,
      required this.applicantSurname,
      required this.userId});

  @override
  State<DetailedListingScreen> createState() => _DetailedListingScreenState();
}

class _DetailedListingScreenState extends State<DetailedListingScreen> {
  String? displayStartDate;
  String? displayEndDate;
  DateTime? startDate;
  DateTime? endDate;
  String? name;

  Future apply() async {
    var url = "http://139.144.77.133/getLocalDemo/apply.php";
    var response = await post(Uri.parse(url), body: {
      "listingId": widget.id,
      "userId": widget.userId,
      "companyId": widget.companyId,
      "name": name
    });

    if (response.statusCode == 200) {
      print("Successfully applied for job!");
      showToast("Application Sent!");
    } else {
      print("An error occured please try again");
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Color.fromARGB(255, 22, 44, 49),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    name = widget.applicantName + " " + widget.applicantSurname;
    Size screenSize = MediaQuery.of(context).size;
    startDate = DateTime.parse(widget.startDate!);
    endDate = DateTime.parse(widget.endDate!);
    displayStartDate = DateFormat('dd MMM').format(startDate!);
    displayEndDate = DateFormat('dd MMM').format(endDate!);
    print(displayStartDate);
    print(displayEndDate);
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    print("Back button tapped");
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color.fromARGB(84, 148, 147, 147)),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.grey),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.job!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.company,
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(1, 1),
                        color: Colors.grey.shade300,
                        blurRadius: 2,
                        spreadRadius: 1),
                    BoxShadow(
                        offset: Offset(-1, -1),
                        color: Colors.grey.shade200,
                        blurRadius: 2,
                        spreadRadius: 0.5)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Start Date: ",
                          style: GoogleFonts.montserrat(
                              color: Colors.grey[600], fontSize: 16)),
                      Text(displayStartDate!,
                          style: GoogleFonts.montserrat(
                              color: Colors.grey[600], fontSize: 16)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("End Date: ",
                          style: GoogleFonts.montserrat(
                              color: Colors.grey[600], fontSize: 16)),
                      Text(displayEndDate!,
                          style: GoogleFonts.montserrat(
                              color: Colors.grey[600], fontSize: 16)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Location: ",
                          style: GoogleFonts.montserrat(
                              color: Colors.grey[600], fontSize: 16)),
                      Text("Piet Retief",
                          style: GoogleFonts.montserrat(
                              color: Colors.grey[600], fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text("Interested in this? ",
                          style: GoogleFonts.montserrat(
                              color: Colors.grey[600], fontSize: 16)),
                      Icon(Icons.arrow_forward),
                      Expanded(
                        child: Container(),
                      ),
                      GradientButton(
                        function: () {
                          apply();
                        },
                        buttonColor1: widget.approved == "true"
                            ? Color.fromARGB(255, 253, 228, 0)
                            : Color.fromARGB(255, 132, 132, 130),
                        buttonColor2: widget.approved == "true"
                            ? Color.fromARGB(255, 194, 176, 9)
                            : Color.fromARGB(255, 132, 132, 130),
                        shadowColor: Colors.grey.shade500,
                        offsetX: 4,
                        offsetY: 4,
                        text: "Apply",
                        width: 100.00,
                        textColor: Colors.black,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            Expanded(child: Container()),
            widget.approved == "false"
                ? Text(
                    "You are not able to apply to jobs until your account has been verified.",
                    style: GoogleFonts.montserrat(
                        fontSize: 16, color: Color.fromARGB(255, 2, 50, 10)),
                    textAlign: TextAlign.center,
                  )
                : Container(),
            Expanded(child: Container())
          ],
        ),
      ),
    );
  }
}
