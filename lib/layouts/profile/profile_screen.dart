import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  final String accountType;
  const ProfileScreen({super.key, required this.accountType});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {},
       backgroundColor: Color.fromARGB(255, 194,242,76),
       child: Icon(Icons.add, color: Colors.black,),),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        color: Colors.white,
        child: Column(
          children: [
                    Row(
              children: [
     
                SizedBox(width: 8),
                Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.grey),
                      child: Icon(Icons.person_2_outlined),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Kosi Connect",
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
               
                      ],
                    ),
                   

             
                  
                  ],
                ),  Expanded(child: Container()),

 
              ],
            ),
             SizedBox(height: 16),
                                 Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,

      decoration: BoxDecoration(
        color: Color.fromARGB(255, 197, 231, 201),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        "Kosi Connect is a pioneering force in the global mining industry, dedicated to responsible extraction and sustainable development. With a rich legacy spanning over two decades, we have firmly established ourselves as a trusted leader in the exploration, extraction, and processing of precious minerals and metals.",
     style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
      ),
    )
          ],
        ),
      ),
    );
  }
}
