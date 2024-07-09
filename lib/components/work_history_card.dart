import 'package:flutter/material.dart';
import 'package:get_local/layouts/LocalAccount/listings/detailed_listing_screen.dart';
import 'package:get_local/layouts/EmployerAccount/listings/detailed_listing_screen_company.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class WorkHistoryCard extends StatefulWidget {
  final String title;
  final String company;
  final String duration;
  final String description;
  const WorkHistoryCard({
    super.key,
    required this.title,
    required this.company,
    required this.duration,
    required this.description,
  });

  @override
  State<WorkHistoryCard> createState() => _WorkHistoryCardState();
}

class _WorkHistoryCardState extends State<WorkHistoryCard> {
  String? displayStartDate;
  String? displayEndDate;
  DateTime? startDate;
  DateTime? endDate;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.grey[100],
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
                              widget.title,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(widget.company,
                              style: GoogleFonts.montserrat(
                                  color: Color.fromARGB(255, 2, 50, 10),
                                  fontSize: 14)),
                          Expanded(child: Container()),
                          Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              color: Color.fromARGB(255, 255, 207, 47),
                            ),
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
