import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';

import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get_local/components/application_card.dart';
import 'package:get_local/components/listing_card.dart';
import 'package:get_local/components/listing_card_applications.dart';
import 'package:get_local/components/shortlist_card.dart';
import 'package:get_local/models/application.dart';
import 'package:get_local/models/listing.dart';
import 'package:get_local/models/shortlisting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' show post;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:intl/intl.dart';

class DetailedListingScreenCompany extends StatefulWidget {
  final String? companyId;
  final String company;

  final String? job;
  final String? startDate;
  final String? endDate;
  final String? id;
  final String? applications;
  final String? interviewDateTime;

  const DetailedListingScreenCompany({
    super.key,
    this.companyId,
    required this.company,
    this.job,
    this.startDate,
    this.endDate,
    this.id,
    this.interviewDateTime,
    this.applications,
  });

  @override
  State<DetailedListingScreenCompany> createState() =>
      _DetailedListingsScreenCompanyState();
}

class _DetailedListingsScreenCompanyState
    extends State<DetailedListingScreenCompany> {
  Timer? timer;
  List<Application> applications = [];
  List<Shortlisting> shortlist = [];
  DateTime? interviewDate;

  int _selectedTab = 0;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 60), (Timer t) {
      getApplications();
    });
    super.initState();
  }

  Future<List<Application>> getApplications() async {
    print("getting applications");
    const jsonEndpoint =
        "http://139.144.77.133/getLocalDemo/getApplications.php";

    Object requestBody = {"listingId": widget.id};

    try {
      final response = await post(
        Uri.parse(jsonEndpoint),
        body: requestBody,
      );
      switch (response.statusCode) {
        case 200:
          List applications = json.decode(response.body);
          print(applications);

          var formatted = applications
              .map((application) => Application.fromJson(application))
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

  Future<List<Shortlisting>> getShortlist() async {
    print("getting shortlist");
    const jsonEndpoint = "http://139.144.77.133/getLocalDemo/getShortlist.php";

    Object requestBody = {"listingId": widget.id};

    try {
      final response = await post(
        Uri.parse(jsonEndpoint),
        body: requestBody,
      );
      switch (response.statusCode) {
        case 200:
          List shortlistedCandidates = json.decode(response.body);
          print(shortlistedCandidates);

          var formatted = shortlistedCandidates
              .map((listing) => Shortlisting.fromJson(listing))
              .toList();
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

  @override
  Widget build(BuildContext context) {
    interviewDate = DateTime.parse(widget.interviewDateTime!);
    String formattedDate = DateFormat('EEEE, MMMM d').format(interviewDate!);
    return LoaderOverlay(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
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
                            borderRadius: BorderRadius.all(Radius.circular(15)),
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
                      widget.job!,
                      style: GoogleFonts.montserrat(
                          color: Color.fromARGB(255, 2, 50, 10),
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular((10))),
                          color: Colors.grey),
                      child: Icon(Icons.engineering_outlined),
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Piet Retief",
                                style: GoogleFonts.montserrat(
                                    color: Colors.grey[900], fontSize: 16)),
                            Row(
                              children: [
                                Text(widget.applications!),
                                widget.applications == "1"
                                    ? Text(" application",
                                        style: GoogleFonts.montserrat(
                                            color: Colors.grey[900],
                                            fontSize: 16))
                                    : Text(" applications",
                                        style: GoogleFonts.montserrat(
                                            color: Colors.grey[900],
                                            fontSize: 16))
                              ],
                            ),
                          ],
                        ),
                        Text("Interview Date: $formattedDate",
                            style: GoogleFonts.montserrat(
                                color: Colors.grey[900], fontSize: 16))
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                FlutterToggleTab(
                  selectedBackgroundColors: [Colors.white],
                  unSelectedBackgroundColors: [
                    Color.fromARGB(255, 241, 243, 252)
                  ],
                  height: 40,
                  width: 92,
                  borderRadius: 15,
                  marginSelected: EdgeInsets.all(4),
                  selectedTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  unSelectedTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  labels: ["Applications", "Shortlist"],
                  selectedIndex: _selectedTab,
                  selectedLabelIndex: (index) {
                    setState(() {
                      _selectedTab = index;
                      print("Selected tab: $_selectedTab");
                    });
                  },
                ),
                _selectedTab == 0
                    ? Expanded(
                        child: FutureBuilder<List<Application>>(
                          future: getApplications(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              if (applications.isNotEmpty) {
                                return Container(
                                  color: Colors.blue,
                                );
                              }
                            } else if (snapshot.hasData &&
                                snapshot.hasError == false) {
                              print("snapshot data :");
                              print(snapshot.data);
                              applications = snapshot.data!;
                              print("Snapshot contains data");

                              if (applications.isNotEmpty) {
                                return Container(
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 24),
                                      Expanded(
                                        child: Container(
                                          child: ListView.builder(
                                            itemCount: applications.length,
                                            itemBuilder: (context, index) {
                                              return ApplicationCard(
                                                  applicationId:
                                                      applications[index]
                                                          .applicationId,
                                                  companyId: applications[index]
                                                      .companyId!,
                                                  listingId: applications[index]
                                                      .listingId,
                                                  userId: applications[index]
                                                      .userId,
                                                  name:
                                                      applications[index].name,
                                                  interviewDateTime:
                                                      widget.interviewDateTime);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (applications.isEmpty) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(flex: 1, child: Container()),
                                      Image.asset(
                                          "assets/images/waiting_graphic.png"),
                                      Text(
                                        "No applications...yet",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 24,
                                            color:
                                                Color.fromARGB(255, 49, 50, 49),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "Once candidates start applying to this job listing you will be able to see and review the applications right here",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            color:
                                                Color.fromARGB(255, 49, 50, 49),
                                            fontWeight: FontWeight.normal),
                                        textAlign: TextAlign.center,
                                      ),
                                      Expanded(flex: 3, child: Container()),
                                    ],
                                  ),
                                );
                              }
                            }
                            return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: const Center(
                                    child: CircularProgressIndicator()));
                          },
                        ),
                      )
                    : Expanded(
                        child: Container(
                        child: FutureBuilder<List<Shortlisting>>(
                          future: getShortlist(),
                          builder: (context, snapshot) {
                            print(snapshot.data);
                            if (snapshot.hasError) {
                              if (shortlist.isNotEmpty) {
                                return Container(
                                  color: Colors.blue,
                                );
                              }
                            } else if (snapshot.hasData &&
                                snapshot.hasError == false) {
                              print("snapshot data :");
                              print(snapshot.data);
                              shortlist = snapshot.data!;
                              print("Snapshot contains shortlist data");

                              if (shortlist.isNotEmpty) {
                                print("show list of candidates");
                                return Container(
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 24),
                                      Expanded(
                                        child: Container(
                                          child: ListView.builder(
                                            itemCount: shortlist.length,
                                            itemBuilder: (context, index) {
                                              return ShortlistCard(
                                                  listingId: shortlist[index]
                                                      .listingId,
                                                  userId:
                                                      shortlist[index].userId,
                                                  name: shortlist[index].name,
                                                  surname:
                                                      shortlist[index].surname);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (shortlist.isEmpty) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(flex: 1, child: Container()),
                                      Image.asset(
                                          "assets/images/waiting_graphic.png"),
                                      Text(
                                        "No shortlisted candidates...yet",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 24,
                                            color:
                                                Color.fromARGB(255, 49, 50, 49),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "Once candidates start applying to this job listing you will be able to see and review the applications right here",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            color:
                                                Color.fromARGB(255, 49, 50, 49),
                                            fontWeight: FontWeight.normal),
                                        textAlign: TextAlign.center,
                                      ),
                                      Expanded(flex: 3, child: Container()),
                                    ],
                                  ),
                                );
                              }
                            }
                            return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: const Center(
                                    child: CircularProgressIndicator()));
                          },
                        ),
                      )),
              ],
            ),
          )),
    );
  }
}
