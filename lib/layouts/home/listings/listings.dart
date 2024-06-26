import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get_local/components/listing_card.dart';
import 'package:get_local/models/listing.dart';
import 'package:http/http.dart' show post;
import 'package:loader_overlay/loader_overlay.dart';

class ListingsScreen extends StatefulWidget {
  final String accountType;
  final String? companyId;
  const ListingsScreen({super.key, required this.accountType, this.companyId});

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
    print("getting posts");
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
              print("Snapshot contains data");

              if (listings.isNotEmpty) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  color: Colors.white,
                  child: Column(
                    children: [
                      FlutterToggleTab(
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
                        labels: ["All", "Bookmarks", "Invites"],
                        selectedIndex: _tabTextIconIndexSelected,
                        selectedLabelIndex: (index) {
                          setState(() {
                            _tabTextIconIndexSelected = index;
                          });
                        },
                      ),
                      SizedBox(height: 20),
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
                            );
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
