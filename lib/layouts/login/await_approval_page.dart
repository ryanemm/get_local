import 'package:flutter/material.dart';
import 'package:get_local/components/gradient_button.dart';
import 'package:get_local/layouts/home/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AwaitingApprovalPage extends StatefulWidget {
  final String accountType;
  final String applicantId;

  String? name;
  String? surname;
  String? email;
  String? password;
  String? approved;
  AwaitingApprovalPage(
      {super.key,
      required this.accountType,
      this.name,
      this.surname,
      this.email,
      this.approved,
      this.password,
      required this.applicantId});

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
              Expanded(child: Container()),
              Text("Thank you for completing for your profile!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              Text(
                  "We will now review your profile and verify the documents you provided. You are able to use GetLocals with limited features until your documents have been verified. We usually respond within 24 hours.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      fontSize: 16, fontWeight: FontWeight.normal)),
              Expanded(child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GradientButton(
                    text: "Continue",
                    buttonColor1: Color.fromARGB(255, 253, 228, 0),
                    buttonColor2: Color.fromARGB(255, 194, 176, 9),
                    textColor: const Color.fromARGB(255, 19, 53, 61),
                    shadowColor: Colors.grey.shade500,
                    offsetX: 4,
                    offsetY: 4,
                    width: 120.00,
                    function: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                  accountType: widget.accountType,
                                  name: widget.name,
                                  surname: widget.surname,
                                  email: widget.email,
                                  password: widget.password,
                                  id: widget.applicantId,
                                  approved: widget.approved)));
                    },
                  ),
                  SizedBox(height: 200)
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
