import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_local/layouts/home/home_screen.dart';
import 'package:get_local/layouts/login/login_screen.dart';
import 'package:get_local/layouts/login/upload_documents_test_page.dart';
import 'package:get_local/file_upload_screen.dart';
import 'package:get_local/upload_test.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: Color.fromARGB(255, 0, 7, 45),
    systemNavigationBarIconBrightness: Brightness.dark
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
   final bool loggedIn = false;
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(
        
        useMaterial3: true,
      ),
      home: loggedIn == true ? HomeScreen() : FileUploadScreen(),
    );
  }
}

