import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_local/components/event_card.dart';
import 'package:get_local/models/events.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' show post;
import 'package:loader_overlay/loader_overlay.dart';

class NotificationsUnverified extends StatefulWidget {
  final String id;
  const NotificationsUnverified({super.key, required this.id});

  @override
  State<NotificationsUnverified> createState() =>
      _NotificationsUnverifiedState();
}

class _NotificationsUnverifiedState extends State<NotificationsUnverified> {
  Timer? timer;
  List<Event> events = [];

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 60), (Timer t) {
      getEvents();
      setState(() {});
    });
    super.initState();
  }

  Future<List<Event>> getEvents() async {
    print("fetching events");
    try {
      const jsonEndpoint =
          "http://139.144.77.133/getLocalDemo/get_events_unverified.php";

      final response = await post(
        Uri.parse(jsonEndpoint),
        body: {"id": widget.id},
      );
      switch (response.statusCode) {
        case 200:
          List events = json.decode(response.body);
          print(events);

          var formatted = events.map((event) => Event.fromJson(event)).toList();
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
        body: FutureBuilder<List<Event>>(
          future: getEvents(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              if (events.isNotEmpty) {
                return Container(
                  color: Colors.blue,
                );
              }
            } else if (snapshot.hasData && snapshot.hasError == false) {
              print("snapshot data :");
              print(snapshot.data);
              events = snapshot.data!;
              print("Snapshot contains data");

              if (events.isEmpty) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      "All notifications for job invites will show here when you are selected for a job you applied for.\n Once your activated you will also be notified here and on the email address you signed up",
                      style: GoogleFonts.montserrat(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              } else if (events.isNotEmpty) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemCount: events.length,
                          itemBuilder: (context, index) {
                            return EventCard(
                              title: events[index].title!,
                              detailedContent: events[index].detailedContent!,
                              dateTimestamp: events[index].dateTimestamp,
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
