import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get_local/components/listing_card.dart';
import 'package:get_local/models/listing.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' show post;
import 'package:loader_overlay/loader_overlay.dart';

class ListingsScreen extends StatefulWidget {
  final String approved;
  final String name;
  final String surname;
  final String userId;

  const ListingsScreen({
    super.key,
    required this.approved,
    required this.name,
    required this.surname,
    required this.userId,
  });

  @override
  State<ListingsScreen> createState() => _ListingsScreenState();
}

class _ListingsScreenState extends State<ListingsScreen> {
  Timer? timer;
  List<Listing> listings = [];

  int _tabTextIconIndexSelected = 0;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 60), (Timer t) {
      getListings();
      setState(() {});
    });
    super.initState();
  }

  Future<List<Listing>> getListings() async {
    print("getting posts for locals");
    const jsonEndpoint = "http://139.144.77.133/getLocalDemo/get_listings.php";

    Object requestBody = "";

    try {
      final response = await post(
        Uri.parse(jsonEndpoint),
        body: "",
      );
      switch (response.statusCode) {
        case 200:
          List listings = json.decode(response.body);
          print(listings);

          var formatted =
              listings.map((post) => Listing.fromJson(post)).toList();
          print(formatted);

          print(formatted);

          return formatted;
        default:
          throw Exception(response.reasonPhrase);
      }
    } on Exception {
      print("Caught an exception: ");
      //return Future.error(e.toString());
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        body: FutureBuilder<List<Listing>>(
          future: getListings(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              if (listings.isNotEmpty) {
                return Container(
                  color: Colors.blue,
                );
              }
            } else if (snapshot.hasData && snapshot.hasError == false) {
              print("snapshot data :");
              print(snapshot.data);
              listings = snapshot.data!;
              listings = listings.reversed.toList();
              print("Snapshot contains data");

              if (listings.isNotEmpty) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Text(
                        "Listings",
                        style: GoogleFonts.montserrat(
                            fontSize: 24,
                            color: Color.fromARGB(255, 2, 50, 10),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: listings.length,
                          itemBuilder: (context, index) {
                            return ListingCard(
                                id: listings[index].id,
                                company: listings[index].company,
                                companyId: listings[index].companyId,
                                job: listings[index].job!,
                                startDate: listings[index].startDate!,
                                endDate: listings[index].endDate!,
                                approved: widget.approved,
                                applicantName: widget.name,
                                applicantSurname: widget.surname,
                                userId: widget.userId);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            }
            return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: const Center(child: CircularProgressIndicator()));
          },
        ),
      ),
    );
  }
}
