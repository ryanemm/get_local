import 'package:flutter/material.dart';
import 'package:get_local/layouts/LocalAccount/listings/detailed_listing_screen.dart';
import 'package:get_local/layouts/EmployerAccount/listings/detailed_listing_screen_company.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ListingCardApplications extends StatefulWidget {
  final String company;
  final String companyId;
  final String? job;
  final String? startDate;
  final String? endDate;
  final String? id;
  final String? applications;
  final String? timestamp;
  final String? interviewDateTime;
  const ListingCardApplications(
      {super.key,
      required this.company,
      required this.companyId,
      this.id,
      this.job,
      this.startDate,
      this.endDate,
      this.applications,
      this.interviewDateTime,
      this.timestamp});

  @override
  State<ListingCardApplications> createState() =>
      _ListingCardApplicationsState();
}

class _ListingCardApplicationsState extends State<ListingCardApplications> {
  String? displayStartDate;
  String? displayEndDate;
  DateTime? startDate;
  DateTime? endDate;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    startDate = DateTime.parse(widget.startDate!);
    endDate = DateTime.parse(widget.endDate!);
    displayStartDate = DateFormat('dd MMM').format(startDate!);
    displayEndDate = DateFormat('dd MMM').format(endDate!);
    print(displayStartDate);
    print(displayEndDate);

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailedListingScreenCompany(
                          id: widget.id!,
                          company: widget.company,
                          companyId: widget.companyId,
                          job: widget.job,
                          applications: widget.applications,
                          startDate: widget.startDate,
                          endDate: widget.endDate,
                          interviewDateTime: widget.interviewDateTime,
                        )));
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 243, 248),
                borderRadius: BorderRadius.all(Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(1, 1),
                      color: Colors.grey.shade300,
                      blurRadius: 2,
                      spreadRadius: 1),
                  BoxShadow(
                      offset: Offset(-1, -1),
                      color: Colors.grey.shade200,
                      blurRadius: 2,
                      spreadRadius: 0.5)
                ]),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular((10))),
                    color: Colors.grey),
                child: Icon(Icons.engineering),
              ),
              SizedBox(width: 8),
              Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.job!,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Text("Piet Retief",
                          style: GoogleFonts.montserrat(
                              color: Colors.grey[900], fontSize: 14)),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text(widget.applications!,
                              style: GoogleFonts.montserrat(
                                  color: Color.fromARGB(255, 63, 191, 72),
                                  fontSize: 14)),
                          widget.applications == "1"
                              ? Text(" application ",
                                  style: GoogleFonts.montserrat(
                                      color: Color.fromARGB(255, 63, 191, 72),
                                      fontSize: 14))
                              : Text(" applications ",
                                  style: GoogleFonts.montserrat(
                                      color: Color.fromARGB(255, 63, 191, 72),
                                      fontSize: 14)),
                          Expanded(child: Container()),
                          Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                color: Color.fromARGB(255, 253, 228, 0)),
                            child: Icon(Icons.chevron_right_outlined,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ],
                  )),
            ]),
          ),
        ),
        SizedBox(
          height: 16,
        )
      ],
    );
  }
}
