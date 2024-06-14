import 'package:flutter/material.dart';
import 'package:get_local/layouts/home/listings/detailed_listing_screen.dart';
import 'package:get_local/layouts/login/login_screen.dart';
import 'package:get_local/layouts/profile/applicant_profile_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ApplicationCard extends StatefulWidget {
  final String? applicationId;
  final String companyId;
  final String? listingId;
  final String? userId;

  const ApplicationCard({
    super.key,
    required this.companyId,
    this.applicationId,
    this.listingId,
    this.userId,
  });

  @override
  State<ApplicationCard> createState() => _ApplicationCardState();
}

class _ApplicationCardState extends State<ApplicationCard> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ApplicantProfileScreen(
                  applicationId: widget.applicationId!,
                  listingId: widget.listingId!
                ),
              ),
            );
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
                  spreadRadius: 1,
                ),
                BoxShadow(
                  offset: Offset(-1, -1),
                  color: Colors.grey.shade200,
                  blurRadius: 2,
                  spreadRadius: 0.5,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey,
                  ),
                  child: Icon(Icons.person_3_outlined),
                ),
                SizedBox(width: 8),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "User account: ",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.userId!,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "View Profile",
                            style: GoogleFonts.montserrat(
                              color: Colors.grey[900],
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                              color: Color.fromARGB(255, 194, 242, 76),
                            ),
                            child: Icon(Icons.chevron_right_outlined, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
