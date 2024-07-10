import 'package:flutter/material.dart';
import 'package:get_local/layouts/EmployerAccount/home_screen_employer.dart';
import 'package:get_local/layouts/LocalAccount/home_screen_local.dart';
import 'package:get_local/layouts/home/feed.dart';
import 'package:get_local/layouts/LocalAccount/listings/listings.dart';
import 'package:get_local/layouts/EmployerAccount/listings/listings_company.dart';
import 'package:get_local/layouts/login/login_screen.dart';
import 'package:get_local/layouts/LocalAccount/notifications/notifications.dart';
import 'package:get_local/layouts/LocalAccount/notifications/notifications_unverified_locals.dart';
import 'package:get_local/layouts/LocalAccount/profile/profile_screen.dart';
import 'package:get_local/layouts/EmployerAccount/profile/profile_screen_company.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:load_switch/load_switch.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final String accountType;
  String? name;
  String? surname;
  String? email;
  String? companyName;
  String? id;
  String? service;
  String? approved;
  String? password;

  HomeScreen(
      {super.key,
      required this.accountType,
      this.surname,
      this.email,
      this.name,
      this.password,
      this.companyName,
      this.id,
      this.service,
      this.approved});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PersistentTabController _controller = PersistentTabController();
  String? accountType;
  String? approved;
  String? email;
  String? name;
  String? surname;
  String? companyName;
  String? id;
  String? service;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: widget.accountType == "local"
            ? HomeScreenLocal(
                id: widget.id,
                email: widget.email,
                name: widget.name,
                surname: widget.surname,
                approved: widget.approved,
              )
            : HomeScreenEmployer(
                id: widget.id,
                email: widget.email,
                companyName: widget.companyName,
                service: widget.service,
              ));
  }
}
