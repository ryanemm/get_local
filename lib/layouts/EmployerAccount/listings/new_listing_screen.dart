import 'package:flutter/material.dart';
import 'package:get_local/components/gradient_button.dart';
import 'package:get_local/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewListingScreen extends StatefulWidget {
  String? companyName;
  String? companyId;
  NewListingScreen({super.key, this.companyId, this.companyName});

  @override
  State<NewListingScreen> createState() => _NewListingScreenState();
}

class _NewListingScreenState extends State<NewListingScreen> {
  DateTime selectedDate = DateTime.now();
  DateTime startDateObj = DateTime.now();
  String? startDate;
  DateTime endDateObj = DateTime.now();
  String? endDate;
  String _chosenModel = "Looking for...";

  Future<void> selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        startDateObj = selectedDate;
        print(startDateObj);
        startDate = DateFormat('dd/MM/yyyy').format(startDateObj);
        print(startDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
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
          SizedBox(height: 32),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(32)),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(4, 7),
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ]),
            child: DropdownButton<String>(
              value: _chosenModel,
              underline: Container(),
              isExpanded: true,
              disabledHint: Text("Job"),
              menuMaxHeight: screenSize.height * 0.2,
              items: <String>[
                'Looking for...',
                'General Worker/Labourer',
                'Dump Truck Operator',
                'Front-End Loader Operator',
                'Excavator Operator',
                'Bulldozer Operator',
                'Grader Operator',
                'Drill Rig Operator',
                'Crane Operator',
                'Dozer Operator',
                'Scrapers Operator',
                'Haul Truck Operator',
                'Backhoe Operator',
                'Rock Truck Operator',
                'Blasting Assistant',
                'Survey Assistant',
                'Electrical or Mechanical Technician Apprentice',
                'Safety Officer',
                'Safety Officer Assistant',
                'Environmental Monitor',
                'Geotechnical Assistant',
                'Clerk/Administrative Assistant',
                'Rescue Team Member',
                'Warehouse/Supply Chain Assistant:',
                'Security Officer/Guard',
                'Health and Wellness Coordinator:',
                'Community Relations Officer:',
                'Jumbo Drill Operator',
                'Longhole Drill Operator',
                'Bolter Operator',
                'LHD Operator (Load-Haul-Dump)',
                'Raiseborer Operator:',
                'Shotcrete Sprayer Operator',
                'Remote Control Equipment Operator',
                'Continuous Miner Operator',
                'Roof Bolter Operator',
                'Scooptram Operator',
                'Shuttle Car Operator:',
                'Mantrip Operator',
                'Belt Conveyor Operator',
                'Rock Bolting Rig Operator:',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _chosenModel = newValue!;

                  print(_chosenModel);
                });
              },
              hint: Text(
                "Choose a Car Model",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(height: 32),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(32)),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(4, 7),
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ]),
            child: GestureDetector(
              onTap: () {
                selectDate(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        color: const Color.fromARGB(255, 19, 53, 61),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Start Date",
                        style: simpleTextStyle(Colors.black),
                      ),
                    ],
                  ),
                  GestureDetector(
                    child: Container(
                      child: Icon(
                        Icons.chevron_right_rounded,
                        color: Color.fromARGB(255, 0, 23, 226),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 32),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(32)),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(4, 7),
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ]),
            child: GestureDetector(
              onTap: () {
                selectDate(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        color: const Color.fromARGB(255, 19, 53, 61),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "End Date",
                        style: simpleTextStyle(Colors.black),
                      ),
                    ],
                  ),
                  GestureDetector(
                    child: Container(
                      child: Icon(
                        Icons.chevron_right_rounded,
                        color: Color.fromARGB(255, 0, 23, 226),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 32),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(32)),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(4, 7),
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ]),
            child: GestureDetector(
              onTap: () {
                selectDate(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        color: const Color.fromARGB(255, 19, 53, 61),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Interview Date",
                        style: simpleTextStyle(Colors.black),
                      ),
                    ],
                  ),
                  GestureDetector(
                    child: Container(
                      child: Icon(
                        Icons.chevron_right_rounded,
                        color: Color.fromARGB(255, 0, 23, 226),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 32),
          TextField(
            maxLines: null, // Allows the text field to grow as needed
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Additional notes or preferences for the job',
            ),
          ),
          Expanded(child: Container()),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GradientButton(
                function: () async {},
                buttonColor1: Color.fromARGB(255, 253, 228, 0),
                buttonColor2: Color.fromARGB(255, 194, 176, 9),
                shadowColor: Colors.grey.shade500,
                offsetX: 4,
                offsetY: 4,
                text: "Add Listing",
                width: 150.00,
                textColor: const Color.fromARGB(255, 19, 53, 61),
              ),
              SizedBox(height: 200)
            ],
          ),
        ],
      ),
    );
  }
}
