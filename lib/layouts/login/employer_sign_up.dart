import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_local/components/gradient_button.dart';
import 'package:get_local/layouts/login/profile_review_page_company.dart';
import 'package:get_local/models/otp_result.dart';
import 'package:get_local/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:http/http.dart' as http;

class EmployerSignUp extends StatefulWidget {
  const EmployerSignUp({super.key});

  @override
  State<EmployerSignUp> createState() => _EmployerSignUpState();
}

class _EmployerSignUpState extends State<EmployerSignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController tradingAsController = TextEditingController();
  TextEditingController OTPController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController serviceController = TextEditingController();
  TextEditingController companyRegistrationController = TextEditingController();

  bool emailPasswordError = false;
  int currentIndex = 0;

  String? email;
  String? password;
  String? companyName;
  String? tradingAs;
  String? address;
  String? phoneNumber;
  String? service;
  String? companyRegistration;

  String? OTP;
  bool showOTPError = false;
  bool OTPVerified = false;

   Future requestOTP() async {
    var url = "http://139.144.77.133/getLocalDemo/otp_mailer.php";
    var response = await http.post(Uri.parse(url), body: {
      "email": email,

    });

    // var data = json.decode(response.body);

    if (response.statusCode == 200) {
      print("OTP Sent to $email");
    }
    if (response.body.contains("Incorrect")) {
      print("Check you the details and verify they are correct");
    }

    /*if (data == "Login Successful.") {
      Fluttertoast.showToast(msg: "Login successful");
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoard(),),);
    } else {
      /*FlutterToast(context).showToast(
          child: Text('Username and password invalid',
              style: TextStyle(fontSize: 25, color: Colors.red)));*/
    }*/
  }

    Future<OTPResult> checkOTP() async {
    var url = "http://139.144.77.133/getLocalDemo/otp_checker.php";
    var response = await http.post(Uri.parse(url), body: {
      "email": email,
      "otp": OTP
    });

    Map<String, dynamic> parsedJson = jsonDecode(response.body);
    OTPResult result = OTPResult.fromJson(parsedJson);

    if (result.result == "correct") {
      print("Correct OTP ");
      OTPVerified = true;
    }
    if (result.result == "incorrect") {
      print("Incorrect OPT");
      showOTPError = true;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    List<Widget> stages = [
      Container(
          key: ValueKey(1),
          height: screenSize.height * 0.25,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(32)),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(4, 7),
                        color: Colors.grey.shade300,
                        blurRadius: 8,
                        spreadRadius: 0,
                      ),
                    ]),
                child: TextFormField(
                  autofocus: true,
                  controller: emailController,
                  style: simpleTextStyle(Colors.black),
                  decoration: textFieldInputDecoration(
                      "Email",
                      const Icon(
                        Icons.email_outlined,
                        color: Color.fromARGB(255, 0, 23, 226),
                      )),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(32)),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(4, 7),
                          color: Colors.grey.shade300,
                          blurRadius: 8,
                          spreadRadius: 0),
                    ]),
                child: TextFormField(
                  controller: passController,
                  obscureText: true,
                  validator: (val) {
                    return val!.length > 8
                        ? null
                        : "Password must have 8 characters or more";
                  },
                  style: simpleTextStyle(Colors.black),
                  decoration: textFieldInputDecoration(
                      "Password",
                      const Icon(
                        Icons.lock_outline,
                        color: Color.fromARGB(255, 0, 23, 226),
                      )),
                ),
              ),
            ],
          )),
      Container(
        key: ValueKey(2),
        height: screenSize.height * 0.25,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              "We have sent a One Time Pin to your email address. Enter to verify your email address",
              style: GoogleFonts.montserrat(
                  fontSize: 12, fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(32)),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(4, 7),
                      color: Colors.grey.shade300,
                      blurRadius: 8,
                      spreadRadius: 0,
                    ),
                  ]),
              child: TextFormField(
                autofocus: true,
                controller: OTPController,
                style: simpleTextStyle(Colors.black),
                decoration: textFieldInputDecoration(
                    "OTP",
                    const Icon(
                      Icons.pin_rounded,
                      color: Color.fromARGB(255, 0, 23, 226),
                    )),
              ),
            ),
            SizedBox(height: 16), 
            showOTPError == true ? 
              Text("Incorrect OTP entered", 
                  style: GoogleFonts.montserrat(
                  fontSize: 16, 
                  fontWeight: FontWeight.bold,
                  color: Colors.red)) : 
              Container()
          ],
        ),
      ),
      Container(
          key: ValueKey(3),
          height: screenSize.height * 0.25,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(32)),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(4, 7),
                          color: Colors.grey.shade300,
                          blurRadius: 8,
                          spreadRadius: 0),
                    ]),
                child: TextFormField(
                  autofocus: true,
                  controller: companyNameController,
                  obscureText: false,
                  style: simpleTextStyle(Colors.black),
                  decoration: textFieldInputDecoration(
                      "Company Name",
                      const Icon(
                        Icons.abc_outlined,
                        color: Color.fromARGB(255, 0, 23, 226),
                      )),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(32)),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(4, 7),
                          color: Colors.grey.shade300,
                          blurRadius: 8,
                          spreadRadius: 0),
                    ]),
                child: TextFormField(
                  controller: tradingAsController,
                  obscureText: false,
                  style: simpleTextStyle(Colors.black),
                  decoration: textFieldInputDecoration(
                      "Trading As",
                      const Icon(
                        Icons.abc_outlined,
                        color: Color.fromARGB(255, 0, 23, 226),
                      )),
                ),
              ),
              const SizedBox(height: 24),
            ],
          )),
      Container(
          key: ValueKey(4),
          height: screenSize.height * 0.25,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(32)),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(4, 7),
                          color: Colors.grey.shade300,
                          blurRadius: 8,
                          spreadRadius: 0,
                        ),
                      ]),
                  child: TextFormField(
                    autofocus: true,
                    controller: addressController,
                    style: simpleTextStyle(Colors.black),
                    decoration: textFieldInputDecoration(
                        "Address",
                        const Icon(
                          Icons.house_outlined,
                          color: Color.fromARGB(255, 0, 23, 226),
                        )),
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(32)),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(4, 7),
                          color: Colors.grey.shade300,
                          blurRadius: 8,
                          spreadRadius: 0,
                        ),
                      ]),
                  child: TextFormField(
                    controller: companyRegistrationController,
                    style: simpleTextStyle(Colors.black),
                    decoration: textFieldInputDecoration(
                        "Company Registration Number",
                        const Icon(
                          Icons.phone_android_outlined,
                          color: Color.fromARGB(255, 0, 23, 226),
                        )),
                  ),
                ),
              ])),
      Container(
          key: ValueKey(5),
          height: screenSize.height * 0.25,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(32)),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(4, 7),
                          color: Colors.grey.shade300,
                          blurRadius: 8,
                          spreadRadius: 0,
                        ),
                      ]),
                  child: TextFormField(
                    autofocus: true,
                    controller: serviceController,
                    style: simpleTextStyle(Colors.black),
                    decoration: textFieldInputDecoration(
                        "Service",
                        const Icon(
                          Icons.calendar_month_outlined,
                          color: Color.fromARGB(255, 0, 23, 226),
                        )),
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(32)),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(4, 7),
                          color: Colors.grey.shade300,
                          blurRadius: 8,
                          spreadRadius: 0,
                        ),
                      ]),
                  child: TextFormField(
                    controller: phoneNumberController,
                    style: simpleTextStyle(Colors.black),
                    decoration: textFieldInputDecoration(
                        "Contact Number",
                        const Icon(
                          Icons.work,
                          color: Color.fromARGB(255, 0, 23, 226),
                        )),
                  ),
                ),
              ])),
    ];
    int totalStages = stages.length;
    Widget signUpStage = stages[currentIndex];
    return LoaderOverlay(
        child: Scaffold(
          appBar: AppBar(
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
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      height: double.infinity,
      color: Colors.grey[50],
      child: Form(
        //key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
       
                    
                                Text(
                                  "Let's create your profile",
                                  style: GoogleFonts.montserrat(
                fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Just a few quick steps",
                                  style: GoogleFonts.montserrat(
                fontSize: 16, fontWeight: FontWeight.normal),
                                ),
              SizedBox(height: 36),
              AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: signUpStage,
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    final offsetAnimation = Tween<Offset>(
                      begin: Offset(currentIndex == 0 ? -1.0 : 1.0, 0.0),
                      end: Offset(0.0, 0.0),
                    ).animate(animation);
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  }
                  // ScaleTransition(child: child, scale: animation),sdfd
                  ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GradientButton(
                    function: () {
                      setState(() {
                      
                        currentIndex - 1 >= 0
                            ? currentIndex = currentIndex - 1
                            : () {};
                        signUpStage = stages[currentIndex];
                        print("gradient button clicked");
                        print(currentIndex);
                      });
                    },
                    buttonColor1: Color.fromARGB(255, 10, 36, 114),
                    buttonColor2: Color.fromARGB(255, 135, 226, 242),
                    shadowColor: Colors.grey.shade500,
                    offsetX: 4,
                    offsetY: 4,
                    text: "Previous",
                    width: 120.00,
                  ),
                  GradientButton(
                    function: () async{
                       if (currentIndex == 0) {
                          email = emailController.text;
                          await requestOTP();
                          currentIndex + 1 < totalStages
                          ? currentIndex = currentIndex + 1
                          : () {};
                          signUpStage = stages[currentIndex];
                          print("next button clicked");
                          print(currentIndex);
                        } else if (currentIndex == 1) {
                          OTP = OTPController.text;
                          await checkOTP();
                          if (OTPVerified == true) {currentIndex + 1 < totalStages
                            ? currentIndex = currentIndex + 1
                            : () {};
                            signUpStage = stages[currentIndex];
                            print("next button clicked");
                            print(currentIndex);
                            } else {
                              OTPController.text = "";
                            }
                        } else if (currentIndex == 4) {
                            email = emailController.text;
                            companyName = companyNameController.text;
                            companyRegistration =
                              companyRegistrationController.text;
                            address = addressController.text;
                            phoneNumber = phoneNumberController.text;
                            tradingAs = tradingAsController.text;
                            service = serviceController.text;
                            password = passController.text;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProfileReviewPageCompany(
                                        email: email!,
                                        companyName: companyName!,
                                        companyRegistration:
                                            companyRegistration!,
                                        address: address!,
                                        phoneNumber: phoneNumber!,
                                        tradingAs: tradingAs!,
                                        service: service!,
                                        password: password!,
                                      )));
                        } else {
                            currentIndex + 1 < totalStages
                            ? currentIndex = currentIndex + 1
                            : () {};
                            signUpStage = stages[currentIndex];
                            print("next button clicked");
                            print(currentIndex);
                        }

                        setState(() {
                          
                        });
                      
                    },
                   buttonColor1: Color.fromARGB(255, 10, 36, 114),
                    buttonColor2: Color.fromARGB(255, 135, 226, 242),
                    shadowColor: Colors.grey.shade500,
                    offsetX: 4,
                    offsetY: 4,
                    text: currentIndex < 4 ? "Next" : "Finish",
                    width: 120.00,
                  ),
                ],
              ),
              const SizedBox(height: 60),
            ]),
      ),
    )));
    ;
  }
}
