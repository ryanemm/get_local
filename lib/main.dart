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
  String? sharedPrefLoggedIn;
  String? sharedPrefAccountType;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Color.fromARGB(255, 0, 7, 45),
      systemNavigationBarIconBrightness: Brightness.dark));

  SharedPreferences startPrefs = await SharedPreferences.getInstance();
  sharedPrefLoggedIn = startPrefs.getString("loggedIn");
  sharedPrefAccountType = startPrefs.getString("accountType");
  if (sharedPrefLoggedIn != null && sharedPrefAccountType != null) {
    loggedIn = sharedPrefLoggedIn;
    accountType = sharedPrefAccountType;
  }

  runApp(MyApp(
    loggedIn: loggedIn,
    accountType: accountType,
  ));
}

class MyApp extends StatelessWidget {
  final String loggedIn;
  final String accountType;
  const MyApp({
    super.key,
    required this.loggedIn,
    required this.accountType,
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
      home: loggedIn == "true"
          ? HomeScreen(
              accountType: accountType,
            )
          : LoginScreen(),
    );
  }
}
