import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get_local/components/work_history_card.dart';
import 'package:get_local/models/work_history.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  final String name;
  final String surname;
  final String email;
  const ProfileScreen(
      {super.key,
      required this.name,
      required this.surname,
      required this.email});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<WorkHistoryItem> workHistoryItems = [
    WorkHistoryItem(
      title: 'Crane Operator',
      company: 'Big Eye Minerals.',
      duration: 'Jan 2020 - Present',
      description: 'Developing mobile applications and web services.',
    ),
    WorkHistoryItem(
      title: 'General Labour',
      company: 'Kosi Connect',
      duration: 'Jun 2018 - Dec 2019',
      description:
          'Assisting in the development of web applications and customer support.',
    ),
    WorkHistoryItem(
      title: 'General Labour',
      company: 'Kosi Connect',
      duration: 'Jun 2018 - Dec 2019',
      description:
          'Assisting in the development of web applications and customer support.',
    ),
    WorkHistoryItem(
      title: 'Crane Operator',
      company: 'Big Eye Minerals.',
      duration: 'Jan 2020 - Present',
      description: 'Developing mobile applications and web services.',
    ),
    WorkHistoryItem(
      title: 'Crane Operator',
      company: 'Big Eye Minerals.',
      duration: 'Jan 2020 - Present',
      description: 'Developing mobile applications and web services.',
    ),
    WorkHistoryItem(
      title: 'Crane Operator',
      company: 'Big Eye Minerals.',
      duration: 'Jan 2020 - Present',
      description: 'Developing mobile applications and web services.',
    ),

    // Add more items here...
  ];
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        color: Colors.white,
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
                          widget.name,
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 2),
                        Text(
                          widget.surname,
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text(
                      "Crane Operator",
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                Expanded(child: Container()),
              ],
            ),
            SizedBox(height: 16),
            DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(20),
              dashPattern: [5, 5],
              color: Colors.grey,
              strokeWidth: 2,
              child: Container(
                height: screenSize.height * 0.2,
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.upload,
                        size: 40,
                        color: Color.fromARGB(255, 253, 228, 0),
                      ),
                      Text(
                        "Certificates",
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: Color.fromARGB(255, 2, 50, 10),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "You can upload any certificates you have here. Certificates increase your chances of getting hired",
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: Color.fromARGB(255, 2, 50, 10)),
                        textAlign: TextAlign.center,
                      )
                    ]),
              ),
            ),
            SizedBox(height: 32),
            Text(
              "Recent Work",
              style: GoogleFonts.montserrat(
                  fontSize: 16, color: Color.fromARGB(255, 2, 50, 10)),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: workHistoryItems.length,
                itemBuilder: (context, index) {
                  return WorkHistoryCard(
                    title: workHistoryItems[index].title,
                    description: workHistoryItems[index].description,
                    duration: workHistoryItems[index].duration,
                    company: workHistoryItems[index].company,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
