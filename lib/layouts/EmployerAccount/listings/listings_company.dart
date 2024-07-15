import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'dart:async';
import 'dart:convert';

import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get_local/components/listing_card.dart';
import 'package:get_local/components/listing_card_applications.dart';
import 'package:get_local/models/listing.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' show post;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:scroll_to_hide/scroll_to_hide.dart';

class ListingsScreenCompany extends StatefulWidget {
  final String? id;
  const ListingsScreenCompany({super.key, this.id});

  @override
  State<ListingsScreenCompany> createState() => _ListingsScreenCompanyState();
}

class _ListingsScreenCompanyState extends State<ListingsScreenCompany> {
  Timer? timer;
  List<Listing> listings = [];
  ScrollController _scrollController = ScrollController();
  double previousScrollPosition = 0.00;
  bool isContainerVisible = true;

  int _tabTextIconIndexSelected = 0;

  @override
  void initState() {
    if (widget.id != "") {
      timer = Timer.periodic(const Duration(seconds: 720), (Timer t) {
        getListings();
        setState(() {});
      });
    }

    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    final currentScrollPosition = _scrollController.position.pixels;

    if (currentScrollPosition == 0.00) {
      // top of the list
      print('Reached the top of the list');
      setState(() {
        isContainerVisible = true;
      });
    } else if (currentScrollPosition > previousScrollPosition) {
      // Scrolling downwards
      print('Scrolling downwards');
      setState(() {
        isContainerVisible = false;
      });
    } else {
      // Scrolling upwards
      print('Scrolling upwards');
      setState(() {
        isContainerVisible = true;
      });
    }
    if (currentScrollPosition == 0.00) {
      // top of the list
      print('Reached the top of the list');
      setState(() {
        isContainerVisible = true;
      });
    }

    previousScrollPosition = currentScrollPosition;
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future<List<Listing>> getListings() async {
    print("getting posts for company");
    const jsonEndpoint =
        "http://139.144.77.133/getLocalDemo/get_company_listings.php";

    Object requestBody = {"companyId": widget.id};

    try {
      final response = await post(
        Uri.parse(jsonEndpoint),
        body: requestBody,
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
              print("Snapshot contains data");

              if (listings.isNotEmpty) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        height: isContainerVisible ? 40 : 0,
                        width: double.infinity,
                        child: FlutterToggleTab(
                          selectedBackgroundColors: [Colors.white],
                          unSelectedBackgroundColors: [
                            Color.fromARGB(255, 241, 243, 252)
                          ],
                          height: 40,
                          width: 92,
                          borderRadius: 15,
                          marginSelected: EdgeInsets.all(4),
                          selectedTextStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          unSelectedTextStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          labels: ["All", "Shortlist"],
                          selectedIndex: _tabTextIconIndexSelected,
                          selectedLabelIndex: (index) {
                            setState(() {
                              _tabTextIconIndexSelected = index;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 8),
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          physics: ClampingScrollPhysics(),
                          itemCount: listings.length,
                          itemBuilder: (context, index) {
                            return ListingCardApplications(
                                id: listings[index].id,
                                company: listings[index].company,
                                companyId: listings[index].companyId,
                                job: listings[index].job!,
                                startDate: listings[index].startDate!,
                                endDate: listings[index].endDate!,
                                interviewDateTime:
                                    listings[index].interviewDateTime,
                                applications: listings[index].applications);
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
