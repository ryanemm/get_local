import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_local/components/work_history_card.dart';
import 'package:get_local/models/account_details_company.dart';
import 'package:get_local/models/account_details_local.dart';
import 'package:get_local/models/work_history.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' show post;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:intl/intl.dart';

class ApplicantProfileScreen extends StatefulWidget {
  final String applicationId;
  final String listingId;
  final String interviewDateTime;

  const ApplicantProfileScreen({
    super.key,
    required this.applicationId,
    required this.listingId,
    required this.interviewDateTime,
  });

  @override
  State<ApplicantProfileScreen> createState() => _ApplicantProfileScreenState();
}

class _ApplicantProfileScreenState extends State<ApplicantProfileScreen> {
  Timer? timer;
  List<AccountDetailsLocal> userAccounts = [];
  DateTime? interviewDateObj;
  String? formattedDate;

  Future<List<AccountDetailsLocal>> getUserAccount() async {
    print("getting user's account for application ID: ");
    print(widget.applicationId);

    const jsonEndpoint =
        "http://139.144.77.133/getLocalDemo/getUserAccount.php";

    Object requestBody = {"applicationId": widget.applicationId};

    try {
      final response = await post(
        Uri.parse(jsonEndpoint),
        body: requestBody,
      );
      switch (response.statusCode) {
        case 200:
          List userAccounts = json.decode(response.body);
          print(userAccounts);

          var formatted = userAccounts
              .map((userAccount) => AccountDetailsLocal.fromJson(userAccount))
              .toList();
          print(formatted);

          print(formatted);

          return formatted;
        default:
          throw Exception(response.reasonPhrase);
      }
    } on Exception {
      print("Caught an exception: ");
      //return Future.error(e.toString());
      rethrow;
    }
  }

  Future sendInterviewInvite() async {
    print("sending interview invite");
    const jsonEndpoint =
        "http://139.144.77.133/getLocalDemo/send_interview_invite.php";

    Object requestBody = {
      "listingId": widget.listingId,
      "email": userAccounts[0].email,
      "userId": userAccounts[0].id
    };

    try {
      final response = await post(
        Uri.parse(jsonEndpoint),
        body: requestBody,
      );
      switch (response.statusCode) {
        case 200:
          print(response.body);
        default:
          throw Exception(response.reasonPhrase);
      }
    } on Exception {
      print("Caught an exception: ");
      //return Future.error(e.toString());
      rethrow;
    }
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Send Interview Invite'),
          content: Text('Invite candidate to an interview on $formattedDate.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Select New Date'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _selectDate(context);
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      // Handle the selected date
      print('Selected date: $pickedDate');
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Color.fromARGB(255, 22, 44, 49),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void initState() {
    getUserAccount();

    super.initState();
  }

  List<WorkHistoryItem> workHistoryItems = [
    WorkHistoryItem(
      title: 'Forklift Operator',
      company: 'Big Eye Minerals.',
      duration: 'Jan 2020 - Present',
      description: 'Developing mobile applications and web services.',
    ),
    WorkHistoryItem(
      title: 'General Labour',
      company: 'Kosi Connect',
      duration: 'Jun 2018 - Dec 2019',
      description:
          'Assisting in the development of web applications and customer support.',
    ),
    WorkHistoryItem(
      title: 'General Labour',
      company: 'Kosi Connect',
      duration: 'Jun 2018 - Dec 2019',
      description:
          'Assisting in the development of web applications and customer support.',
    ),
    WorkHistoryItem(
      title: 'Forklift Operator',
      company: 'Big Eye Minerals.',
      duration: 'Jan 2020 - Present',
      description: 'Developing mobile applications and web services.',
    ),

    // Add more items here...
  ];
  @override
  Widget build(BuildContext context) {
    interviewDateObj = DateTime.parse(widget.interviewDateTime);
    formattedDate = DateFormat('EEEE, MMMM d').format(interviewDateObj!);
    return LoaderOverlay(
      child: Scaffold(
        body: FutureBuilder<List<AccountDetailsLocal>>(
          future: getUserAccount(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              if (userAccounts.isNotEmpty) {
                return Container(
                  color: Colors.blue,
                );
              }
            } else if (snapshot.hasData && snapshot.hasError == false) {
              print("snapshot data :");
              print(snapshot.data);
              userAccounts = snapshot.data!;
              print("Snapshot contains data");

              if (userAccounts.isNotEmpty) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Text(
                            userAccounts[0].name,
                            style: GoogleFonts.montserrat(
                                color: Color.fromARGB(255, 2, 50, 10),
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 2),
                          Text(
                            userAccounts[0].surname,
                            style: GoogleFonts.montserrat(
                                color: Color.fromARGB(255, 2, 50, 10),
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: Container()),
                          GestureDetector(
                            onTap: () {
                              //showToast("Invitation sent to applicant");
                              _showDialog(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(12),
                              width: 100,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color.fromARGB(255, 253, 228, 0),
                                  Color.fromARGB(255, 194, 176, 9),
                                ]),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text("Invite",
                                    style: GoogleFonts.montserrat(
                                        color: const Color.fromARGB(
                                            255, 19, 53, 61),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 46),
                          Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Colors.grey),
                            child: Icon(Icons.person_2_outlined),
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userAccounts[0].job,
                                style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.phone),
                                  Text(
                                    userAccounts[0].phoneNumber,
                                    style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 32),
                      Text("Work History:",
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.normal)),
                      SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: workHistoryItems.length,
                          itemBuilder: (context, index) {
                            return WorkHistoryCard(
                              title: workHistoryItems[index].title,
                              description: workHistoryItems[index].description,
                              duration: workHistoryItems[index].duration,
                              company: workHistoryItems[index].company,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            }
            return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: const Center(child: CircularProgressIndicator()));
          },
        ),
      ),
    );
  }
}
