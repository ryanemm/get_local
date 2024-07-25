import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailedPostScreen extends StatefulWidget {
  final String company;
  final String title;
  final String content;
  final String imageUrl;
  final String companyProfilePicUrl;
  const DetailedPostScreen(
      {super.key,
      required this.company,
      required this.title,
      required this.content,
      required this.imageUrl,
      required this.companyProfilePicUrl});

  @override
  State<DetailedPostScreen> createState() => _DetailedPostScreenState();
}

class _DetailedPostScreenState extends State<DetailedPostScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
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
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        border: Border.all(color: Colors.grey)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      child: Image.network(
                        widget.companyProfilePicUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          }
                        },
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Icon(Icons.person_2_outlined);
                        },
                      ),
                    )),
                SizedBox(width: 16),
                Text(
                  widget.company,
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Color.fromARGB(255, 2, 50, 10),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  widget.title,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      color: Color.fromARGB(255, 2, 50, 10),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8),
            Container(
                height: screenSize.height * 0.25,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: Colors.grey.shade300)),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      }
                    },
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Icon(Icons.person_2_outlined);
                    },
                  ),
                )),
            SizedBox(height: 16),
            Text(
              widget.content,
              style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Color.fromARGB(255, 2, 50, 10),
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
