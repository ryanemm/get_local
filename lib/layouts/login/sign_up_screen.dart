import 'package:flutter/material.dart';
import 'package:get_local/components/gradient_button.dart';
import 'package:get_local/layouts/login/employer_sign_up.dart';
import 'package:get_local/layouts/login/local_sign_up.dart';
import 'package:get_local/layouts/login/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
        child: Scaffold(
          appBar:  AppBar(
            elevation: 0,
            backgroundColor: Colors.grey[50],
            leading:   GestureDetector(
                onTap: () {
                  print("Back button tapped");
                  Navigator.pop(context);
                },
                child: Center(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
         ),
            body: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                height: double.infinity,
                color: Colors.grey[50],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      
                    Expanded(flex: 3, child: Container()),
                    Text(
                      "Let's Get You Started",
                      style: GoogleFonts.montserrat(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text("Are you a: ",
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 16)),
                    SizedBox(height: 24),
                    GradientButton(
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LocalSignUp()));
                      },
                      buttonColor1: Color.fromARGB(255, 10, 36, 114),
                      buttonColor2: Color.fromARGB(255, 97, 178, 245),
                      shadowColor: Colors.grey.shade500,
                      offsetX: 4,
                      offsetY: 4,
                      text: "Local",
                      width: double.infinity,
                    ),
                    SizedBox(height: 24),
                    GradientButton(
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EmployerSignUp()));
                      },
                      buttonColor1: Color.fromARGB(255, 10, 36, 114),
                      buttonColor2: Color.fromARGB(255, 97, 178, 245),
                      shadowColor: Colors.grey.shade500,
                      offsetX: 4,
                      offsetY: 4,
                      text: "Employer",
                      width: double.infinity,
                    ),
                    Expanded(flex: 1, child: Container()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account? ",
                            style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 16)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text(
                            "Sign in",
                            style: GoogleFonts.montserrat(
                                color: Color.fromARGB(255, 10, 36, 114),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 50)
                  ],
                ))));
  }
}
