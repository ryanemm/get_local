import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_local/layouts/home/home_screen.dart';
import 'package:get_local/layouts/login/login_screen.dart';
import 'package:get_local/layouts/login/upload_documents_page.dart';
import 'package:get_local/layouts/login/upload_documents_test_page.dart';
import 'package:get_local/file_upload_screen.dart';
import 'package:get_local/upload_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String loggedIn = "";
  String accountType = "";
  String name = "";
  String surname = "";
  String email = "";
  String? sharedPrefLoggedIn;
  String? sharedPrefAccountType;
  String? sharedPrefEmail;
  String? sharedPrefName;
  String? sharedPrefSurname;

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Color.fromARGB(255, 0, 7, 45),
      systemNavigationBarIconBrightness: Brightness.dark));

  SharedPreferences startPrefs = await SharedPreferences.getInstance();
  sharedPrefLoggedIn = startPrefs.getString("loggedIn");
  sharedPrefAccountType = startPrefs.getString("accountType");
  sharedPrefName = startPrefs.getString("name");
  sharedPrefSurname = startPrefs.getString("surname");
  sharedPrefEmail = startPrefs.getString("email");
  if (sharedPrefLoggedIn != null &&
      sharedPrefAccountType != null &&
      sharedPrefEmail != null &&
      sharedPrefName != null &&
      sharedPrefSurname != null) {
    loggedIn = sharedPrefLoggedIn;
    accountType = sharedPrefAccountType;
    email = sharedPrefEmail;
    name = sharedPrefName;
    surname = sharedPrefSurname;
  }

  runApp(MyApp(
    loggedIn: loggedIn,
    accountType: accountType,
    email: email,
    name: name,
    surname: surname,
  ));
}

class MyApp extends StatelessWidget {
  final String loggedIn;
  final String accountType;
  final String name;
  final String surname;
  final String email;
  const MyApp({
    super.key,
    required this.loggedIn,
    required this.accountType,
    required this.name,
    required this.surname,
    required this.email,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(loggedIn);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      home: (loggedIn == "true" && accountType == "local")
          ? HomeScreen(
              accountType: accountType,
              name: name,
              surname: surname,
              email: email)
          : LoginScreen(),
    );
  }
}
