import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_local/components/gradient_button.dart';
import 'package:get_local/components/image_button.dart';
import 'package:get_local/layouts/login/local_documents_upload.dart';
import 'package:get_local/layouts/login/profile_review_page.dart';
import 'package:get_local/models/otp_result.dart';
import 'package:get_local/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:intl/intl.dart';
import 'package:timelines/timelines.dart';
import 'package:http/http.dart' as http;

class LocalSignUp extends StatefulWidget {
  const LocalSignUp({super.key});

  @override
  State<LocalSignUp> createState() => _LocalSignUpState();
}

class _LocalSignUpState extends State<LocalSignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController OTPController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  bool emailPasswordError = false;
  int currentIndex = 0;

  String? email;
  String? password;
  String? name;
  String? surname;
  String? address;
  String? phoneNumber;
  String? dateOfBirth;
  String? job;
  String? OTP;
  DateTime dateOfBirthObj = DateTime.now();

  String _chosenModel = "title";
  DateTime selectedDate = DateTime.now();
  bool OTPVerified = false;

  Future<void> selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        dateOfBirthObj = selectedDate;
        print(dateOfBirthObj);
        dateOfBirth = DateFormat('dd/MM/yyyy').format(dateOfBirthObj);
        print(dateOfBirth);
      });
    }
  }

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
                  autofocus: false,
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
                  controller: nameController,
                  obscureText: false,
                  style: simpleTextStyle(Colors.black),
                  decoration: textFieldInputDecoration(
                      "Name",
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
                  controller: surnameController,
                  obscureText: false,
                  style: simpleTextStyle(Colors.black),
                  decoration: textFieldInputDecoration(
                      "Surname",
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
                    controller: phoneNumberController,
                    style: simpleTextStyle(Colors.black),
                    decoration: textFieldInputDecoration(
                        "Phone Number",
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
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                  child: GestureDetector(
                    onTap: () {
                      selectDate(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month_outlined,
                              color: Color.fromARGB(255, 0, 23, 226),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Date of Birth",
                              style: simpleTextStyle(Colors.black),
                            ),
                          ],
                        ),
                        GestureDetector(
                          child: Container(
                            child: Icon(
                              Icons.chevron_right_rounded,
                              color: Color.fromARGB(255, 0, 23, 226),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                  child: DropdownButton<String>(
                    value: _chosenModel,
                    underline: Container(),
                    isExpanded: true,
                    disabledHint: Text("Job"),
                    menuMaxHeight: screenSize.height * 0.2,
                    items: <String>[
                      'title',
                      'General Worker/Labourer',
                      'Dump Truck Operator',
                      'Front-End Loader Operator',
                      'Excavator Operator',
                      'Bulldozer Operator',
                      'Grader Operator',
                      'Drill Rig Operator',
                      'Crane Operator',
                      'Dozer Operator',
                      'Scrapers Operator',
                      'Haul Truck Operator',
                      'Backhoe Operator',
                      'Rock Truck Operator',
                      'Blasting Assistant',
                      'Survey Assistant',
                      'Electrical or Mechanical Technician Apprentice',
                      'Safety Officer',
                      'Safety Officer Assistant',
                      'Environmental Monitor',
                      'Geotechnical Assistant',
                      'Clerk/Administrative Assistant',
                      'Rescue Team Member',
                      'Warehouse/Supply Chain Assistant:',
                      'Security Officer/Guard',
                      'Health and Wellness Coordinator:',
                      'Community Relations Officer:',
                      'Jumbo Drill Operator',
                      'Longhole Drill Operator',
                      'Bolter Operator',
                      'LHD Operator (Load-Haul-Dump)',
                      'Raiseborer Operator:',
                      'Shotcrete Sprayer Operator',
                      'Remote Control Equipment Operator',
                      'Continuous Miner Operator',
                      'Roof Bolter Operator',
                      'Scooptram Operator',
                      'Shuttle Car Operator:',
                      'Mantrip Operator',
                      'Belt Conveyor Operator',
                      'Rock Bolting Rig Operator:',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _chosenModel = newValue!;

                        print(_chosenModel);
                      });
                    },
                    hint: Text(
                      "Choose a Car Model",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )
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
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: Color.fromARGB(84, 148, 147, 147)),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
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
                  SizedBox(width: 16),
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

                            }
                        } else if (currentIndex == 4) {
                            email = emailController.text;
                            password = passController.text;
                            name = nameController.text;
                            surname = surnameController.text;
                            address = addressController.text;
                            phoneNumber = phoneNumberController.text;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileReviewPage(
                                        email: email!,
                                        password: password!,
                                        name: name!,
                                        surname: surname!,
                                        address: address!,
                                        phoneNumber: phoneNumber!,
                                        dateOfBirth: dateOfBirth!,
                                        job: _chosenModel,
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
  }
}
