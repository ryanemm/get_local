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
  String companyName = "";
  String id = "";
  String service = "";
  String approved = "";
  String password = "";
  String job = "";
  String? sharedPrefLoggedIn;
  String? sharedPrefAccountType;
  String? sharedPrefEmail;
  String? sharedPrefName;
  String? sharedPrefSurname;
  String? sharedPrefCompanyName;
  String? sharedPrefId;
  String? sharedPrefService;
  String? sharedPrefApproved;
  String? sharedPrefPassword;
  String? sharedPrefJob;

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Color.fromARGB(255, 0, 7, 45),
      systemNavigationBarIconBrightness: Brightness.dark));

  SharedPreferences startPrefs = await SharedPreferences.getInstance();
  sharedPrefLoggedIn = startPrefs.getString("loggedIn");

  if (sharedPrefLoggedIn != null && sharedPrefLoggedIn == "true") {
    sharedPrefAccountType = startPrefs.getString("accountType");
    accountType = sharedPrefAccountType!;
    if (sharedPrefAccountType == "local") {
      sharedPrefName = startPrefs.getString("name");
      sharedPrefSurname = startPrefs.getString("surname");
      sharedPrefEmail = startPrefs.getString("email");
      sharedPrefId = startPrefs.getString("id");
      sharedPrefApproved = startPrefs.getString("approved");
      sharedPrefLoggedIn = startPrefs.getString("loggedIn");
      sharedPrefPassword = startPrefs.getString("password");
      sharedPrefJob = startPrefs.getString("job");
      email = sharedPrefEmail!;
      name = sharedPrefName!;
      surname = sharedPrefSurname!;
      approved = sharedPrefApproved!;
      loggedIn = sharedPrefLoggedIn!;
      password = sharedPrefPassword!;
      job = sharedPrefJob!;
      print(email);
      print(name);
      print(surname);
      print(accountType);
      if (sharedPrefId != null) {
        id = sharedPrefId!;
      }
      print(id);
    } else if (sharedPrefAccountType == "employer") {
      sharedPrefId = startPrefs.getString("id");
      sharedPrefService = startPrefs.getString("service");
      sharedPrefCompanyName = startPrefs.getString("companyName");
      sharedPrefEmail = startPrefs.getString("email");
      sharedPrefApproved = startPrefs.getString("approved");
      sharedPrefLoggedIn = startPrefs.getString("loggedIn");
      id = sharedPrefId!;
      service = sharedPrefService!;
      companyName = sharedPrefCompanyName!;
      email = sharedPrefEmail!;
      approved = sharedPrefApproved!;
      loggedIn = sharedPrefLoggedIn!;
    }
  }

  runApp(MyApp(
      loggedIn: loggedIn,
      accountType: accountType,
      email: email,
      name: name,
      surname: surname,
      companyName: companyName,
      service: service,
      job: job,
      id: id,
      approved: approved,
      password: password));
}

class MyApp extends StatelessWidget {
  final String loggedIn;
  final String accountType;
  final String name;
  final String surname;
  final String email;
  final String companyName;
  final String service;
  final String id;
  final String approved;
  final String password;
  final String job;
  const MyApp(
      {super.key,
      required this.loggedIn,
      required this.accountType,
      required this.name,
      required this.surname,
      required this.email,
      required this.companyName,
      required this.service,
      required this.id,
      required this.approved,
      required this.password,
      required this.job});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("Logged in: $loggedIn");
    print("Verified: $approved");

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      home: (loggedIn == "true")
          ? HomeScreen(
              accountType: accountType,
              name: name,
              surname: surname,
              email: email,
              companyName: companyName,
              service: service,
              id: id,
              password: password,
              approved: approved,
              job: job,
            )
          : LoginScreen(),
    );
  }
}
