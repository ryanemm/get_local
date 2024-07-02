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
  String? sharedPrefLoggedIn;
  String? sharedPrefAccountType;
  String? sharedPrefEmail;
  String? sharedPrefName;
  String? sharedPrefSurname;
  String? sharedPrefCompanyName;
  String? sharedPrefId;
  String? sharedPrefService;

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Color.fromARGB(255, 0, 7, 45),
      systemNavigationBarIconBrightness: Brightness.dark));

  SharedPreferences startPrefs = await SharedPreferences.getInstance();
  sharedPrefLoggedIn = startPrefs.getString("loggedIn");

  if (sharedPrefLoggedIn != null) {
    sharedPrefAccountType = startPrefs.getString("accountType");
    if (sharedPrefAccountType == "local") {
      sharedPrefName = startPrefs.getString("name");
      sharedPrefSurname = startPrefs.getString("surname");
      sharedPrefEmail = startPrefs.getString("email");
      sharedPrefId = startPrefs.getString("id");
      email = sharedPrefEmail!;
      name = sharedPrefName!;
      surname = sharedPrefSurname!;
      id = sharedPrefId!;
    } else if (sharedPrefAccountType == "employer") {
      sharedPrefId = startPrefs.getString("id");
      sharedPrefService = startPrefs.getString("service");
      sharedPrefCompanyName = startPrefs.getString("companyName");
      sharedPrefEmail = startPrefs.getString("email");
      id = sharedPrefId!;
      service = sharedPrefService!;
      companyName = sharedPrefCompanyName!;
      email = sharedPrefEmail!;
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
      id: id));
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
  const MyApp({
    super.key,
    required this.loggedIn,
    required this.accountType,
    required this.name,
    required this.surname,
    required this.email,
    required this.companyName,
    required this.service,
    required this.id,
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
      home: (loggedIn == "true")
          ? HomeScreen(
              accountType: accountType,
              name: name,
              surname: surname,
              email: email,
              companyName: companyName,
              service: service)
          : LoginScreen(),
    );
  }
}
