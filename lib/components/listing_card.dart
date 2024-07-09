import 'package:flutter/material.dart';
import 'package:get_local/layouts/LocalAccount/listings/detailed_listing_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ListingCard extends StatefulWidget {
  final String company;
  final String companyId;
  final String? job;
  final String? startDate;
  final String? endDate;
  final String? id;
  final String approved;
  const ListingCard(
      {super.key,
      required this.company,
      required this.companyId,
      this.id,
      this.job,
      this.startDate,
      this.endDate,
      required this.approved});

  @override
  State<ListingCard> createState() => _ListingCardState();
}

class _ListingCardState extends State<ListingCard> {
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
                    builder: (context) => DetailedListingScreen(
                        id: widget.id!,
                        company: widget.company,
                        companyId: widget.companyId,
                        job: widget.job,
                        startDate: widget.startDate,
                        endDate: widget.endDate,
                        approved: widget.approved)));
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(1, 1),
                      color: Colors.grey.shade200,
                      blurRadius: 6,
                      spreadRadius: 0),
                  BoxShadow(
                      offset: Offset(-1, -1),
                      color: Colors.grey.shade200,
                      blurRadius: 6,
                      spreadRadius: 0)
                ]),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color.fromARGB(255, 247, 243, 165)),
                child: Center(
                  child: Text(
                    "BE",
                    style: GoogleFonts.montserrat(color: Colors.black),
                  ),
                ),
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
                          Icon(Icons.bookmark_outline)
                        ],
                      ),
                      Text(widget.company,
                          style: GoogleFonts.montserrat(
                              color: Colors.grey[600], fontSize: 16)),
                      Row(
                        children: [
                          Text("Start: ",
                              style: GoogleFonts.montserrat(
                                  color: Colors.grey[600], fontSize: 16)),
                          Text(displayStartDate!,
                              style: GoogleFonts.montserrat(
                                  color: Colors.grey[600], fontSize: 16)),
                          Expanded(child: Container()),
                          Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                size: 14,
                              ),
                              Text(
                                "Piet Retief",
                                style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          ),
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
