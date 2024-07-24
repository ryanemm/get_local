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
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

class UploadDocumentsPage extends StatefulWidget {
  final String profileType;
  final String applicantId;
  final String accountType;
  String? password;
  String? name;
  String? surname;
  String? email;
  String? approved;
  String? job;
  String? companyName;
  String? service;
  UploadDocumentsPage(
      {super.key,
      required this.profileType,
      required this.applicantId,
      required this.accountType,
      this.name,
      this.surname,
      this.email,
      this.password,
      this.job,
      this.companyName,
      this.service,
      this.approved});

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
  String? user_id;
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
    user_id = widget.applicantId;
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
        Uri.parse('http://139.144.77.133/getLocalDemo/document_upload_mod.php');
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

  Future<void> uploadFilesWithNewNames1(
      List<File> files, List<String> newNames) async {
    int length = documents.length;
    print("Document list contains $length files");
    final uri =
        Uri.parse("http://139.144.77.133/getLocalDemo/document_upload_mod.php");

    var request = http.MultipartRequest('POST', uri);

    // Adding files to the request
    for (int i = 0; i < files.length; i++) {
      File file = files[i];
      String fileName = newNames[i];

      var mimeTypeData =
          lookupMimeType(file.path, headerBytes: [0xFF, 0xD8])?.split('/');
      var fileStream = http.ByteStream(file.openRead());
      var fileLength = await file.length();

      request.files.add(http.MultipartFile(
        'files[]', // field name on the server, updated to 'files[]'
        fileStream,
        fileLength,
        filename: fileName,
        contentType: mimeTypeData != null
            ? MediaType(mimeTypeData[0], mimeTypeData[1])
            : null,
      ));
    }

    // Adding newNames as a field in the request
    request.fields['newNames'] = json.encode(newNames);

    // Sending the request
    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await http.Response.fromStream(response);
        print('Response: ${responseBody.body}');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
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
                  SizedBox(height: 8),
                  Text(
                    "All files should be in PDF format",
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.normal),
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
                                      Color.fromARGB(255, 253, 228, 0),
                                  buttonColor2:
                                      Color.fromARGB(255, 194, 176, 9),
                                  textColor:
                                      const Color.fromARGB(255, 19, 53, 61),
                                  shadowColor: Colors.grey.shade500,
                                  offsetX: 4,
                                  offsetY: 4,
                                  width: 120.00,
                                  function: () async {
                                    documents
                                        .add(uploadCardsCompany[0].document!);
                                    documents
                                        .add(uploadCardsCompany[1].document!);
                                    documents
                                        .add(uploadCardsCompany[2].document!);
                                    print("uploading documents");
                                    await uploadFilesWithNewNames1(documents, [
                                      "company_$user_id\_company_profile.pdf",
                                      "company_$user_id\_CIPC.pdf",
                                      "company_$user_id\_proof_of_address.pdf"
                                    ]);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AwaitingApprovalPage(
                                                    applicantId:
                                                        widget.applicantId,
                                                    accountType:
                                                        widget.accountType,
                                                    email: widget.email,
                                                    companyName:
                                                        widget.companyName,
                                                    service: widget.service,
                                                    approved: "false")));
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
                                      Color.fromARGB(255, 253, 228, 0),
                                  buttonColor2:
                                      Color.fromARGB(255, 194, 176, 9),
                                  textColor:
                                      const Color.fromARGB(255, 19, 53, 61),
                                  shadowColor: Colors.grey.shade500,
                                  offsetX: 4,
                                  offsetY: 4,
                                  width: 60.00,
                                  function: () async {
                                    documents
                                        .add(uploadCardsLocal[0].document!);
                                    documents
                                        .add(uploadCardsLocal[1].document!);
                                    documents
                                        .add(uploadCardsLocal[2].document!);
                                    print("uploading documents");
                                    await uploadFilesWithNewNames1(documents, [
                                      "local_$user_id\_ID.pdf",
                                      "local_$user_id\_proof_of_res.pdf",
                                      "local_$user_id\_CV.pdf"
                                    ]);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AwaitingApprovalPage(
                                                    applicantId:
                                                        widget.applicantId,
                                                    accountType:
                                                        widget.accountType,
                                                    name: widget.name,
                                                    surname: widget.surname,
                                                    email: widget.email,
                                                    password: widget.password,
                                                    job: widget.job,
                                                    companyName:
                                                        widget.companyName,
                                                    service: widget.service,
                                                    approved: "false")));
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
