import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_local/components/image_button.dart';
import 'package:get_local/layouts/home/home_screen.dart';
import 'package:get_local/layouts/login/sign_up_screen.dart';
import 'package:get_local/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show post;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool emailPasswordError = false;
  double shadowOffsetX = 4;
  double shadowOffsetY = 7;

  void updateSharePreferences(String email, String trackerId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("email", email);
    await prefs.setString("tracker_id", trackerId);

    print("updated shared preferences");
  }

  /*Future login() async {
    print("attempting login...");
    assert(EmailValidator.validate(
      emailController.text.trim(),
    ));
    Future.delayed(const Duration(milliseconds: 300), () {
      context.loaderOverlay.show();
    });

    var url = "http://139.144.77.133/getLocalDemo/login.php";
    var response = await http.post(Uri.parse(url), body: {
      "email": emailController.text.trim(),
      "password": passController.text,
    });

    List data = json.decode(response.body);
    print("Raw data =>");
    print(data);
    var deviceDetails =
        data.map((device) => DeviceDetails.fromJson(device)).toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (deviceDetails.isNotEmpty) {
      print("No. of devices: ");
      print(deviceDetails.length);
      print(deviceDetails);
      List<String> deviceList = [];
      int deviceListLength = deviceDetails.length;
      for (int i = 0; i < deviceListLength; i++) {
        String rawJson = jsonEncode(deviceDetails[i].toMap());
        deviceList.add(rawJson);
      }
      print(deviceList);
      if (Platform.isAndroid) {
        registerDeviceToken();
      }
      prefs.setStringList("devices", deviceList);
      prefs.setBool("loggedIn", true);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(
                    
                  )));
    } else {
      context.loaderOverlay.hide();
      setState(() {
        emailPasswordError = true;
        passController.clear();
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    bool textFieldActive = false;
    return LoaderOverlay(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 19, 53, 61),
        ),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Container(
                    color: const Color.fromARGB(255, 22, 44, 49),
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  Container(
                    height: 32,
                    color: const Color.fromARGB(255, 19, 53, 61),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(32)),
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                color: Colors.grey[50],
                child: Form(
                  //key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Welcome!",
                        style: GoogleFonts.montserrat(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 31, 69, 77)),
                      ),
                      Text(
                        "Please sign in to continue",
                        style: GoogleFonts.montserrat(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        height: 36,
                        child: Center(
                          child: emailPasswordError
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Email or password is incorrect",
                                      style: simpleTextStyle(Colors.red),
                                    ),
                                  ],
                                )
                              : const SizedBox(height: 1),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(32)),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(4, 7),
                                color: Colors.grey.shade300,
                                blurRadius: 8,
                                spreadRadius: 0,
                              ),
                            ]),
                        child: TextFormField(
                          controller: emailController,
                          style: simpleTextStyle(Colors.black),
                          decoration: textFieldInputDecoration(
                              "Email",
                              const Icon(
                                Icons.email_outlined,
                                color: Color.fromARGB(255, 31, 69, 77),
                              )),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(32)),
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
                                color: Color.fromARGB(255, 31, 69, 77),
                              )),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                textFieldActive = true;
                                print("active");
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              child: Text(
                                "Forgot password?",
                                style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ImageButton(
                            function: () {},
                            buttonColor1: Color.fromARGB(255, 253, 228, 0),
                            buttonColor2: Color.fromARGB(255, 194, 176, 9),
                            shadowColor: Colors.grey.shade500,
                            offsetX: shadowOffsetX,
                            offsetY: shadowOffsetY,
                            text: "Sign In",
                            width: 150,
                            textColor: const Color.fromARGB(255, 19, 53, 61),
                            iconImage: Image.asset(
                              "assets/images/sign_in_icon.png",
                              height: 25,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account? ",
                              style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16)),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpPage()));
                            },
                            child: Text(
                              "Sign up",
                              style: GoogleFonts.montserrat(
                                  color: Color.fromARGB(255, 31, 69, 77),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
