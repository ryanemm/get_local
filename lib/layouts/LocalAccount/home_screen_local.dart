import 'package:flutter/material.dart';
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

class HomeScreenLocal extends StatefulWidget {
  String? name;
  String? surname;
  String? email;
  String? id;
  String? approved;
  String? job;

  HomeScreenLocal(
      {super.key,
      this.surname,
      this.email,
      this.name,
      this.id,
      this.approved,
      this.job});
  @override
  _HomeScreenLocalState createState() => _HomeScreenLocalState();
}

class _HomeScreenLocalState extends State<HomeScreenLocal> {
  PersistentTabController _controller = PersistentTabController();
  bool switchValue = false;

  String? approved;
  String? email;
  String? name;
  String? surname;

  @override
  void initState() {
    super.initState();

    //getUserDetails();
    _controller = PersistentTabController(initialIndex: 0);
  }

  Future<bool> _getFuture() async {
    await Future.delayed(const Duration(seconds: 1));
    return !switchValue;
  }

  Future getUserDetails() async {
    SharedPreferences userDetails = await SharedPreferences.getInstance();
    name = userDetails.getString("name");
    email = userDetails.getString("email");
    surname = userDetails.getString("surname");
    approved = userDetails.getString("approved");
    print("Email: $email");
    print("Name: $name");
    print("Surname: $surname");
    print("Approved: $approved");
  }

  Future<void> logout() async {
    SharedPreferences userDetails = await SharedPreferences.getInstance();
    userDetails.clear();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
    print("User logged out");
  }

  List<Widget> _buildScreens() {
    return [
      const Feed(),
      ListingsScreen(
        approved: widget.approved!,
      ),
      widget.approved == "true"
          ? NotificationsScreen(
              id: widget.id!,
            )
          : NotificationsUnverifiedLocals(
              id: widget.id!,
              email: widget.email!,
              name: widget.name!,
              surname: widget.surname!),
      ProfileScreen(
          name: widget.name!,
          surname: widget.surname!,
          email: widget.email!,
          approved: widget.approved!,
          job: widget.job!)
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Color.fromARGB(255, 255, 207, 47),
        inactiveColorPrimary: Colors.grey[200],
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.work),
        title: "Listings",
        activeColorPrimary: Color.fromARGB(255, 255, 207, 47),
        inactiveColorPrimary: Colors.grey[200],
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.notifications),
        title: "Notifications",
        activeColorPrimary: Color.fromARGB(255, 255, 207, 47),
        inactiveColorPrimary: Colors.grey[200],
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: "Profile",
        activeColorPrimary: Color.fromARGB(255, 255, 207, 47),
        inactiveColorPrimary: Colors.grey[200],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 32,
                width: 32,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset("assets/images/logo_yellow.png"),
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        title: Text(
          "GetLocals",
          style: GoogleFonts.aboreto(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              logout();
            },
            child: const Icon(
              Icons.menu_rounded,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8),
        ],
        backgroundColor: Color.fromARGB(255, 22, 44, 49),
      ),
      body: Column(
        children: [
          Container(
            height: 24,
            color: Color.fromARGB(255, 22, 44, 49),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(24))),
            ),
          ),
          Expanded(
            child: PersistentTabView(
              context,
              controller: _controller,
              screens: _buildScreens(),
              items: _navBarsItems(),
              confineInSafeArea: true,
              backgroundColor:
                  Color.fromARGB(255, 22, 44, 49), // Default is Colors.white.
              handleAndroidBackButtonPress: true, // Default is true.
              resizeToAvoidBottomInset:
                  true, // This needs to be true if you want to move up the screen when the keyboard appears.
              stateManagement: true, // Default is true.
              hideNavigationBarWhenKeyboardShows:
                  true, // Recommended to set 'true' to hide bottom nav bar when keyboard appears.
              decoration: NavBarDecoration(
                borderRadius: BorderRadius.circular(100.0),
                colorBehindNavBar: Color.fromARGB(255, 0, 7, 45),
              ),
              popAllScreensOnTapOfSelectedTab: true,
              itemAnimationProperties: const ItemAnimationProperties(
                duration: Duration(milliseconds: 200),
                curve: Curves.ease,
              ),
              screenTransitionAnimation: const ScreenTransitionAnimation(
                animateTabTransition: true,
                curve: Curves.ease,
                duration: Duration(milliseconds: 500),
              ),
              navBarStyle: NavBarStyle
                  .style14, // Choose the nav bar style with this property.
            ),
          ),
        ],
      ),
    );
  }
}
