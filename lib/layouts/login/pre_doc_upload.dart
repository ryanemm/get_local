import 'package:flutter/material.dart';
import 'package:get_local/components/gradient_button.dart';
import 'package:get_local/layouts/login/upload_documents_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

class PreDocUploadPage extends StatefulWidget {
  final String profileType;
  final String applicantId;
  final String accountType;
  String? password;
  String? name;
  String? surname;
  String? email;
  String? job;
  String? approved;
  String? companyName;
  String? service;
  PreDocUploadPage(
      {super.key,
      required this.profileType,
      required this.applicantId,
      required this.accountType,
      this.name,
      this.surname,
      this.email,
      this.job,
      this.approved,
      this.companyName,
      this.service,
      this.password});

  @override
  State<PreDocUploadPage> createState() => _PreDocUploadPageState();
}

class _PreDocUploadPageState extends State<PreDocUploadPage> {
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
        child: Scaffold(
      body: Container(
        color: Colors.grey[50],
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        height: double.infinity,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Congratulations! Your profile is 75% complete. ",
              style: GoogleFonts.montserrat(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 32),
          widget.profileType == "local"
              ? Text(
                  "To finalise your Get Local registration you will need to upload your ID, Proof of Residence and CV. ",
                  style: GoogleFonts.montserrat(
                      fontSize: 16, fontWeight: FontWeight.normal))
              : Text(
                  "To finalise your Get Local registration you will need to upload your Company Profile, Proof of Address and CIPC. ",
                  style: GoogleFonts.montserrat(
                      fontSize: 16, fontWeight: FontWeight.normal)),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GradientButton(
                text: "Proceed to Upload",
                buttonColor1: Color.fromARGB(255, 253, 228, 0),
                buttonColor2: Color.fromARGB(255, 194, 176, 9),
                textColor: const Color.fromARGB(255, 19, 53, 61),
                shadowColor: Colors.grey.shade500,
                offsetX: 4,
                offsetY: 4,
                width: 200.00,
                function: () {
                  widget.accountType == "local"
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UploadDocumentsPage(
                                  profileType: widget.profileType,
                                  applicantId: widget.applicantId,
                                  accountType: widget.accountType,
                                  name: widget.name,
                                  surname: widget.surname,
                                  email: widget.email,
                                  password: widget.password,
                                  job: widget.job,
                                  approved: "false")))
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UploadDocumentsPage(
                                    profileType: widget.profileType,
                                    applicantId: widget.applicantId,
                                    accountType: widget.accountType,
                                    companyName: widget.companyName,
                                    email: widget.email,
                                    service: widget.service,
                                    approved: "false",
                                  )));
                },
              ),
            ],
          ),
        ]),
      ),
    ));
  }
}
