import 'package:flutter/material.dart';
import 'package:get_local/layouts/home/feed.dart';
import 'package:get_local/layouts/home/listings/listings.dart';
import 'package:get_local/layouts/home/listings/listings_company.dart';
import 'package:get_local/layouts/login/login_screen.dart';
import 'package:get_local/layouts/notifications/notifications.dart';
import 'package:get_local/layouts/profile/profile_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:load_switch/load_switch.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final String accountType;

  const HomeScreen({super.key, required this.accountType});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PersistentTabController _controller = PersistentTabController();
  bool switchValue = false;
  String accoutType = "company";
  String companyId = "1";
  String? email;
  String? name;
  String? surname;

  @override
  void initState() {
    super.initState();
    getUserDetails();
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
    print("Email: $email");
    print("Name: $name");
    print("Surname: $surname");
    print(widget.accountType);
  }

  Future<void> logout() async {
    SharedPreferences userDetails = await SharedPreferences.getInstance();
    await userDetails.setString("email", "");
    await userDetails.setString("name", "");
    await userDetails.setString("surname", "");
    await userDetails.setString("loggedIn", "false");
    Navigator.pop(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
    print("User logged out");
  }

  List<Widget> _buildScreens() {
    return [
      const Feed(),
      accoutType == "local"
          ? const ListingsScreen(accountType: "local")
          : ListingsScreenCompany(
              companyId: companyId,
            ),
      NotificationsScreen(),
      const ProfileScreen(accountType: "local"),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.work),
        title: "Listings",
        activeColorPrimary: Color.fromARGB(255, 31, 69, 77),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.notifications),
        title: "Notifications",
        activeColorPrimary: Color.fromARGB(255, 31, 69, 77),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: "Profile",
        activeColorPrimary: Color.fromARGB(255, 31, 69, 77),
        inactiveColorPrimary: Colors.grey,
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
        backgroundColor: Color.fromARGB(255, 31, 69, 77),
      ),
      body: Column(
        children: [
          Container(
            height: 24,
            color: Color.fromARGB(255, 31, 69, 77),
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
                  Color.fromARGB(255, 0, 7, 45), // Default is Colors.white.
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
