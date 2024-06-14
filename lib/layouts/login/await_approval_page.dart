import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AwaitingApprovalPage extends StatefulWidget {
  const AwaitingApprovalPage({super.key});

  @override
  State<AwaitingApprovalPage> createState() => _AwaitingApprovalPageState();
}

class _AwaitingApprovalPageState extends State<AwaitingApprovalPage> {
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
        child: Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        height: double.infinity,
        color: Colors.grey[50],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Thank you for completing for your profile!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              Text(
                  "We will now review your profile and verify the documents you provided. We usually respond within 24 hours.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      fontSize: 16, fontWeight: FontWeight.normal))
            ],
          ),
        ),
      ),
    ));
  }
}
