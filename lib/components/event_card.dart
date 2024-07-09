import 'package:flutter/material.dart';
import 'package:get_local/layouts/LocalAccount/listings/detailed_listing_screen.dart';
import 'package:get_local/layouts/EmployerAccount/listings/detailed_listing_screen_company.dart';
import 'package:get_local/layouts/LocalAccount/notifications/detailed_event_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EventCard extends StatefulWidget {
  final String title;
  final String notification;
  final String? time;
  final Function() function;

  const EventCard({
    super.key,
    required this.title,
    required this.notification,
    this.time,
    required this.function,
  });

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
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
                            widget.title!,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Text(widget.notification,
                        style: GoogleFonts.montserrat(
                            color: Colors.grey[900], fontSize: 14)),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Text("Tap to begin using your account",
                            style: GoogleFonts.montserrat(
                                color: Color.fromARGB(255, 63, 191, 72),
                                fontSize: 14)),
                        Expanded(child: Container()),
                        GestureDetector(
                          onTap: () {
                            widget.function();
                          },
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                color: Color.fromARGB(255, 194, 242, 76)),
                            child: Icon(Icons.chevron_right_outlined,
                                color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ],
                )),
          ]),
        ),
        SizedBox(
          height: 16,
        )
      ],
    );
  }
}
