import 'package:flutter/material.dart';
import 'package:get_local/components/document_upload_card.dart';
import 'package:get_local/components/gradient_button.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadTest extends StatefulWidget {
  const UploadTest({super.key});

  @override
  State<UploadTest> createState() => _UploadTestState();
}

class _UploadTestState extends State<UploadTest> {

  List<String> requiredDocumentsLocal = ["ID", "Proof of Residence", "CV"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],),
        body:  Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [        
            SizedBox(height: 32),
            Text(
              "Please upload your supporting documents",
              style: GoogleFonts.montserrat(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            DocumentUploadCard(
              requiredDocument: requiredDocumentsLocal[0]),
            SizedBox(height: 32),
            GradientButton(
                          text: "Submit Documents",
                          buttonColor1: Color.fromARGB(255, 10, 36, 114),
                          buttonColor2: Color.fromARGB(255, 135, 226, 242),
                          shadowColor: Colors.grey.shade500,
                          offsetX: 4,
                          offsetY: 4,
                          width: 220.00,
                          function: () {
                  
                          },
                        ),],),
        )
        );
  }
}