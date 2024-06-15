import 'package:flutter/material.dart';
import 'package:get_local/components/gradient_button.dart';
import 'package:get_local/layouts/login/profile_review_page_company.dart';
import 'package:get_local/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                      GestureDetector(
                        onTap: () {
                          print("Back button tapped");
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              color: Color.fromARGB(84, 148, 147, 147)),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                   Expanded(
                    flex: 2,
                    child: Container()),
                  Text(
                    "Let's create your profile",
                    style: GoogleFonts.montserrat(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Just a few quick steps",
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.normal),
                  )
                ],
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
                  // ScaleTransition(child: child, scale: animation),
                  ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GradientButton(
                    function: () {
                      setState(() {
                        if (currentIndex == 4) {
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
                        }
                        currentIndex + 1 < totalStages
                            ? currentIndex = currentIndex + 1
                            : () {};
                        signUpStage = stages[currentIndex];
                        print("next button clicked");
                        print(currentIndex);
                      });
                    },
                    buttonColor1: Color.fromARGB(255, 0, 23, 226),
                    buttonColor2: Color.fromARGB(255, 97, 178, 245),
                    shadowColor: Colors.grey.shade500,
                    offsetX: 4,
                    offsetY: 4,
                    text: currentIndex < 4 ? "Next" : "Finish",
                    width: 120.00,
                  ),
                ],
              ),
              const SizedBox(height: 22),
            ]),
      ),
    )));
    ;
  }
}
