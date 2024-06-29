import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_local/components/document_upload_card.dart';
import 'package:get_local/components/gradient_button.dart';
import 'package:get_local/layouts/login/await_approval_page.dart';
import 'package:get_local/layouts/login/pre_doc_upload.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:http/http.dart' as http;

class UploadDocumentsPage extends StatefulWidget {
  final String profileType;
  final String applicantId;
  const UploadDocumentsPage(
      {super.key, required this.profileType, required this.applicantId});

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
  File? _document;
  List<File> documents = [];
  String? filename;
  String? applicantId;
  bool documentUploaded = false;
  List<DocumentUploadCard> uploadCardsLocal = [
    DocumentUploadCard(
      requiredDocument: "ID",
    ),
    DocumentUploadCard(requiredDocument: "Proof of Residence"),
    DocumentUploadCard(requiredDocument: "CV"),
  ];
  List<DocumentUploadCard> uploadCardsCompany = [
    DocumentUploadCard(requiredDocument: "Company Profile"),
    DocumentUploadCard(requiredDocument: "CIPC"),
    DocumentUploadCard(requiredDocument: "Proof of Adress"),
  ];

  @override
  void initState() {
    // TODO: implement initState
    applicantId = widget.applicantId;
  }

  Future<File> changeFileNameOnly(File file, String newFileName) {
    var path = file.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newFileName;
    return file.rename(newPath);
  }

  Future<void> _uploadFile() async {
    print("uploading files");
    if (widget.profileType == "company") {
      print("company account");
      documents.add(uploadCardsCompany[0].document!);
      documents.add(uploadCardsCompany[1].document!);
      documents.add(uploadCardsCompany[2].document!);
    } else if (widget.profileType == "local") {
      print("local account");
      documents.add(uploadCardsLocal[0].document!);
      documents.add(uploadCardsLocal[1].document!);
      documents.add(uploadCardsLocal[2].document!);
    }

    print(documents.length);

    final uri =
        Uri.parse('http://139.144.77.133/getLocalDemo/document_upload.php');
    final request = http.MultipartRequest('POST', uri);

    for (File document in documents) {
      request.files
          .add(await http.MultipartFile.fromPath('files[]', document.path));
    }
    //final request = http.MultipartRequest('POST', uri)
    //..files.add(await http.MultipartFile.fromPath('file', _document!.path));
    final response = await request.send();

    if (response.statusCode == 200) {
      print('Files uploaded successfully');
      //var data = json.decode(response.stream);
      print(response.stream.transform(utf8.decoder).listen((data) {
        print(data);
      }));
    } else {
      print('File upload failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.profileType);
    Size screenSize = MediaQuery.of(context).size;
    return LoaderOverlay(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[50],
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
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
                                uploadCardsCompany[0],
                                uploadCardsCompany[1],
                                uploadCardsCompany[2],
                                GradientButton(
                                  text: "Submit Documents",
                                  buttonColor1:
                                      Color.fromARGB(255, 10, 36, 114),
                                  buttonColor2:
                                      Color.fromARGB(255, 135, 226, 242),
                                  shadowColor: Colors.grey.shade500,
                                  offsetX: 4,
                                  offsetY: 4,
                                  width: 120.00,
                                  function: () async {
                                    await _uploadFile();
                                    /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PreDocUploadPage(
                                          profileType: "local",
                                        )));*/
                                  },
                                ),
                                SizedBox(height: 16),
                              ],
                            )
                          : ListView(
                              children: [
                                uploadCardsLocal[0],
                                uploadCardsLocal[1],
                                uploadCardsLocal[2],
                                GradientButton(
                                  text: "Submit",
                                  buttonColor1:
                                      const Color.fromARGB(255, 19, 53, 61),
                                  buttonColor2:
                                      const Color.fromARGB(255, 179, 237, 169),
                                  shadowColor: Colors.grey.shade500,
                                  offsetX: 4,
                                  offsetY: 4,
                                  width: 60.00,
                                  function: () async {
                                    await _uploadFile();
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
            )));
  }
}
