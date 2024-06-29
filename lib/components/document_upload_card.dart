import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_local/components/gradient_button.dart';
import 'package:get_local/layouts/login/pre_doc_upload.dart';
import 'package:get_local/layouts/login/upload_documents_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class DocumentUploadCard extends StatefulWidget {
  final String requiredDocument;
  File? document;

  DocumentUploadCard(
      {super.key, required this.requiredDocument, this.document});

  @override
  State<DocumentUploadCard> createState() => _DocumentUploadCardState();
}

class _DocumentUploadCardState extends State<DocumentUploadCard> {
  bool documentUploaded = false;
  String? filename;
  final Widget fileIcon = SvgPicture.asset(
    "assets/images/file.svg",
    semanticsLabel: "file icon",
  );

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    setState(() {
      if (result != null) {
        widget.document = File(result.files.single.path!);
        filename = result.files.single.name;
        documentUploaded = true;

        print("Document selected");
      } else {
        print('No file selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(20),
            dashPattern: [5, 5],
            color: Colors.grey,
            strokeWidth: 2,
            child: Container(
              height: screenSize.height * 0.2,
              width: double.infinity,
              decoration: BoxDecoration(),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    fileIcon,
                    SizedBox(height: 16),
                    Text(
                      documentUploaded == false
                          ? widget.requiredDocument
                          : filename!,
                      style: documentUploaded == false
                          ? GoogleFonts.montserrat(fontSize: 16)
                          : GoogleFonts.montserrat(
                              fontSize: 16, color: Colors.blue),
                    )
                  ]),
            ),
          ),
          SizedBox(height: 16),
          GradientButton(
              text: "Browse",
              buttonColor1: const Color.fromARGB(255, 19, 53, 61),
              buttonColor2: const Color.fromARGB(255, 179, 237, 169),
              shadowColor: Colors.grey.shade500,
              offsetX: 4,
              offsetY: 4,
              width: 120.00,
              function: _pickFile),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
