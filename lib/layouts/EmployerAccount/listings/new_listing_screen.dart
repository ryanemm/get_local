import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewListingScreen extends StatefulWidget {
  String? companyName;
  String? companyId;
  NewListingScreen({super.key, this.companyId, this.companyName});

  @override
  State<NewListingScreen> createState() => _NewListingScreenState();
}

class _NewListingScreenState extends State<NewListingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                "Add New Listing",
                style: GoogleFonts.montserrat(
                    fontSize: 24,
                    color: Color.fromARGB(255, 2, 50, 10),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
