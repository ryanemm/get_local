import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';

import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get_local/components/application_card.dart';
import 'package:get_local/components/listing_card.dart';
import 'package:get_local/components/listing_card_applications.dart';
import 'package:get_local/models/application.dart';
import 'package:get_local/models/listing.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' show post;
import 'package:loader_overlay/loader_overlay.dart';

class DetailedListingScreenCompany extends StatefulWidget {
  final String? companyId;
  final String company;

  final String? job;
  final String? startDate;
  final String? endDate;
  final String? id;
  final String? applications;
  const DetailedListingScreenCompany(
      {super.key,
      this.companyId,
      required this.company,
      this.job,
      this.startDate,
      this.endDate,
      this.id,
      this.applications});

  @override
  State<DetailedListingScreenCompany> createState() =>
      _DetailedListingsScreenCompanyState();
}

class _DetailedListingsScreenCompanyState
    extends State<DetailedListingScreenCompany> {
  Timer? timer;
  List<Application> applications = [];

  int _tabTextIconIndexSelected = 0;

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

          var formatted =
              applications.map((post) => Application.fromJson(post)).toList();
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

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        body: FutureBuilder<List<Application>>(
          future: getApplications(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              if (applications.isNotEmpty) {
                return Container(
                  color: Colors.blue,
                );
              }
            } else if (snapshot.hasData && snapshot.hasError == false) {
              print("snapshot data :");
              print(snapshot.data);
              applications = snapshot.data!;
              print("Snapshot contains data");

              if (applications.isNotEmpty) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  color: Colors.white,
                  child: Column(
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
                      SizedBox(height: 8),
                      Text(
                        widget.job!,
                        style: GoogleFonts.montserrat(
                            color: Color.fromARGB(255, 2, 50, 10),
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular((10))),
                                color: Colors.grey),
                            child: Icon(Icons.engineering_outlined),
                          ),
                          SizedBox(width: 8),
                          Text("Piet Retief",
                              style: GoogleFonts.montserrat(
                                  color: Colors.grey[900], fontSize: 16)),
                          Expanded(child: Container()),
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
                          )
                        ],
                      ),
                      SizedBox(height: 24),
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                            itemCount: applications.length,
                            itemBuilder: (context, index) {
                              return ApplicationCard(
                                applicationId:
                                    applications[index].applicationId,
                                companyId: applications[index].companyId!,
                                listingId: applications[index].listingId,
                                userId: applications[index].userId,
                              );
                            },
                          ),
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
