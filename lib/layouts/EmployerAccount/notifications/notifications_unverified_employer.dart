import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_local/components/event_card.dart';
import 'package:get_local/components/event_card_verification.dart';
import 'package:get_local/layouts/home/home_screen.dart';
import 'package:get_local/models/apllicant_id.dart';
import 'package:get_local/models/events.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' show post;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsUnverifiedEmployer extends StatefulWidget {
  final String id;
  final String email;
  final String password;

  const NotificationsUnverifiedEmployer({
    super.key,
    required this.id,
    required this.email,
    required this.password,
  });

  @override
  State<NotificationsUnverifiedEmployer> createState() =>
      _NotificationsUnverifiedEmployerState();
}

class _NotificationsUnverifiedEmployerState
    extends State<NotificationsUnverifiedEmployer> {
  Timer? timer;
  List<Event> events = [];
  String? user_id;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 20), (Timer t) {
      getEvents();
      setState(() {});
    });
    print("ID: ");
    print(widget.id);
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

  Future getUserId() async {
    print("fetching user ID");

    const jsonEndpoint = "http://139.144.77.133/getLocalDemo/get_user_id.php";

    final response = await post(
      Uri.parse(jsonEndpoint),
      body: {"email": widget.email, "password": widget.password},
    );

    if (response.statusCode == 200) {
      List user_ids = json.decode(response.body);
      var formatted =
          user_ids.map((account) => ApplicantId.fromJson(account)).toList();
      user_id = formatted[0].id;
      print("Account ID: $user_id");
      print("saving ID and changing verification state");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("id", user_id!);
      await prefs.setString("approved", "true");

      Restart.restartApp();

      /*Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(
                  id: user_id,
                  accountType: widget.accountType,
                  name: widget.name,
                  surname: widget.surname,
                  email: widget.email,
                  password: widget.password,
                  approved: "true")));*/
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
                  child: Column(
                    children: [
                      Text(
                        "Notifications",
                        style: GoogleFonts.montserrat(
                            fontSize: 24,
                            color: Color.fromARGB(255, 2, 50, 10),
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Text(
                        "All notifications for job invites will show here when you are selected for a job you applied for.\n \nOnce your account is activated you will also be notified here and on the email address you signed up",
                        style: GoogleFonts.montserrat(
                            fontSize: 16, fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                      Expanded(
                        child: Container(),
                      )
                    ],
                  ),
                );
              } else if (events.isNotEmpty) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Text(
                        "Notifications",
                        style: GoogleFonts.montserrat(
                            fontSize: 24,
                            color: Color.fromARGB(255, 2, 50, 10),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemCount: events.length,
                          itemBuilder: (context, index) {
                            return EventCard(
                              title: events[index].title!,
                              notification: events[index].notification,
                              time: events[index].time,
                              function: () {
                                getUserId();
                              },
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
