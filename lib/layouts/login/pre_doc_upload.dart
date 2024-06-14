import 'package:flutter/material.dart';
import 'package:get_local/components/gradient_button.dart';
import 'package:get_local/layouts/login/upload_documents_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

class PreDocUploadPage extends StatefulWidget {
  final String profileType;
  const PreDocUploadPage({super.key, required this.profileType});

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
                buttonColor1: Color.fromARGB(255, 0, 23, 226),
                buttonColor2: Color.fromARGB(255, 97, 178, 245),
                shadowColor: Colors.grey.shade500,
                offsetX: 4,
                offsetY: 4,
                width: 200.00,
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UploadDocumentsPage(
                              profileType: widget.profileType)));
                },
              ),
            ],
          ),
        ]),
      ),
    ));
  }
}
