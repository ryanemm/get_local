import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_local/components/document_upload_card.dart';
import 'package:get_local/components/gradient_button.dart';
import 'package:get_local/layouts/login/await_approval_page.dart';
import 'package:get_local/layouts/login/pre_doc_upload.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

class UploadDocumentsPage extends StatefulWidget {
  final String profileType;
  const UploadDocumentsPage({super.key, required this.profileType});

  @override
  State<UploadDocumentsPage> createState() => _UploadDocumentsPageState();
}

class _UploadDocumentsPageState extends State<UploadDocumentsPage> {
  final Widget fileIcon = SvgPicture.asset(
    "assets/images/file.svg",
    semanticsLabel: "file icon",
  );

  List<String> requiredDocumentsCompany = [
    "Company Profile",
    "CIPC",
    "Proof of Address"
  ];

  List<String> requiredDocumentsLocal = ["ID", "Proof of Residence", "CV"];
  List<File> fileList = [];

  @override
  Widget build(BuildContext context) {
    final Map params = Map();

    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: LoaderOverlay(
          child: Scaffold(
              body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        height: double.infinity,
        color: Colors.grey[50],
        child: Column(
          children: [
            SizedBox(height: 32),
            Text(
              "Please upload your supporting documents",
              style: GoogleFonts.montserrat(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            Expanded(
              child: Container(
                //height: screenSize.height * 0.7,
                child: widget.profileType == "company"
                    ? ListView(
                        children: [
                          DocumentUploadCard(
                              requiredDocument: requiredDocumentsCompany[0]),
                          DocumentUploadCard(
                              requiredDocument: requiredDocumentsCompany[1]),
                          DocumentUploadCard(
                              requiredDocument: requiredDocumentsCompany[2]),
                          GradientButton(
                            text: "Submit Documents",
                            buttonColor1: Color.fromARGB(255, 0, 23, 226),
                            buttonColor2: Color.fromARGB(255, 97, 178, 245),
                            shadowColor: Colors.grey.shade500,
                            offsetX: 4,
                            offsetY: 4,
                            width: 120.00,
                            function: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PreDocUploadPage(
                                            profileType: "local",
                                          )));
                            },
                          ),
                          SizedBox(height: 16),
                        ],
                      )
                    : ListView(
                        children: [
                          DocumentUploadCard(
                              requiredDocument: requiredDocumentsLocal[0]),
                          DocumentUploadCard(
                              requiredDocument: requiredDocumentsLocal[1]),
                          DocumentUploadCard(
                              requiredDocument: requiredDocumentsLocal[2]),
                          GradientButton(
                            text: "Submit Documents",
                            buttonColor1: Color.fromARGB(255, 0, 23, 226),
                            buttonColor2: Color.fromARGB(255, 97, 178, 245),
                            shadowColor: Colors.grey.shade500,
                            offsetX: 4,
                            offsetY: 4,
                            width: 120.00,
                            function: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AwaitingApprovalPage()));
                            },
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ))),
    );
  }
}
