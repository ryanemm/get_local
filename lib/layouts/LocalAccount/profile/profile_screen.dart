import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_local/components/work_history_card.dart';
import 'package:get_local/models/work_history.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  final String name;
  final String surname;
  final String email;
  final String approved;
  final String job;
  final String id;
  const ProfileScreen(
      {super.key,
      required this.name,
      required this.surname,
      required this.email,
      required this.approved,
      required this.job,
      required this.id});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profilePic;
  String? profilePicName;
  String? id;
  String profilePicUrl = "";
  final ImagePicker _picker = ImagePicker();

  List<WorkHistoryItem> workHistoryItems = [
    WorkHistoryItem(
      title: 'Crane Operator',
      company: 'Big Eye Minerals.',
      duration: 'Jan 2020 - Present',
      description: 'Developing mobile applications and web services.',
    ),
    WorkHistoryItem(
      title: 'General Labour',
      company: 'Kosi Connect',
      duration: 'Jun 2018 - Dec 2019',
      description:
          'Assisting in the development of web applications and customer support.',
    ),
    WorkHistoryItem(
      title: 'General Labour',
      company: 'Kosi Connect',
      duration: 'Jun 2018 - Dec 2019',
      description:
          'Assisting in the development of web applications and customer support.',
    ),
    WorkHistoryItem(
      title: 'Crane Operator',
      company: 'Big Eye Minerals.',
      duration: 'Jan 2020 - Present',
      description: 'Developing mobile applications and web services.',
    ),
    WorkHistoryItem(
      title: 'Crane Operator',
      company: 'Big Eye Minerals.',
      duration: 'Jan 2020 - Present',
      description: 'Developing mobile applications and web services.',
    ),
    WorkHistoryItem(
      title: 'Crane Operator',
      company: 'Big Eye Minerals.',
      duration: 'Jan 2020 - Present',
      description: 'Developing mobile applications and web services.',
    ),

    // Add more items here...
  ];

  @override
  void initState() {
    id = widget.id;
    profilePicName = "local_$id\_profile_pic";
    profilePicUrl =
        "http://139.144.77.133/getLocalDemo/documents/local_$id\_profile_pic.jpg";
    super.initState();
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Use the image
      print('Image path: ${image.path}');
      File pic = File(image.path);
      String fileExtension = path.extension(pic.path);
      print("File extension: $fileExtension");
      await uploadProfilePic(pic, profilePicName! + fileExtension);
      _refreshImage();
    }
  }

  void _refreshImage() {
    setState(() {
      // Append a unique query parameter to force refresh
      profilePicUrl =
          'http://139.144.77.133/getLocalDemo/documents/local_$id\_profile_pic.jpg?timestamp=${DateTime.now().millisecondsSinceEpoch}';
    });
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 242, 251, 242),
          elevation: 16,
          shadowColor: Colors.black,
          contentTextStyle: GoogleFonts.montserrat(
              color: Color.fromARGB(255, 2, 50, 10),
              fontSize: 16,
              fontWeight: FontWeight.normal),
          title: Row(
            children: [
              Icon(Icons.person),
              SizedBox(width: 8),
              Text('Profile Picture'),
            ],
          ),
          titleTextStyle: GoogleFonts.montserrat(
              color: Color.fromARGB(255, 2, 50, 10),
              fontSize: 24,
              fontWeight: FontWeight.bold),
          content: Text('Would you like to pick a picture for your profile?'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.montserrat(
                    color: Color.fromARGB(255, 2, 50, 10),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                pickImage();
              },
              child: Text(
                'Select Image',
                style: GoogleFonts.montserrat(
                    color: Color.fromARGB(255, 2, 50, 10),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    setState(() {
      if (result != null) {
        _profilePic = File(result.files.single.path!);
        //filename = result.files.single.name;
        uploadProfilePic(_profilePic!, profilePicName!);
        print("Document selected");
      } else {
        print('No file selected.');
      }
    });
  }

  Future<void> uploadProfilePic(File file, String newName) async {
    final uri =
        Uri.parse("http://139.144.77.133/getLocalDemo/profile_pic_upload.php");

    var request = http.MultipartRequest('POST', uri);

    // Add widget.name to the file name
    String fileName = newName;

    var mimeTypeData =
        lookupMimeType(file.path, headerBytes: [0xFF, 0xD8])?.split('/');
    var fileStream = http.ByteStream(file.openRead());
    var fileLength = await file.length();

    request.files.add(http.MultipartFile(
      'files[]', // field name on the server
      fileStream,
      fileLength,
      filename: fileName,
      contentType: mimeTypeData != null
          ? MediaType(mimeTypeData[0], mimeTypeData[1])
          : null,
    ));

    // Adding newName as a field in the request
    request.fields['newNames'] = json.encode([fileName]);

    // Sending the request
    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await http.Response.fromStream(response);
        print('Response: ${responseBody.body}');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    _showDialog(context);
                  },
                  child: Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.grey,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Image.network(
                          profilePicUrl,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                ),
                              );
                            }
                          },
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Icon(Icons.person_2_outlined);
                          },
                        ),
                      )),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.name,
                          style: GoogleFonts.montserrat(
                              color: Color.fromARGB(255, 2, 50, 10),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 6),
                        Text(
                          widget.surname,
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text(
                      widget.job,
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                Expanded(child: Container()),
              ],
            ),
            SizedBox(height: 16),
            DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(20),
              dashPattern: [5, 5],
              color: Colors.grey,
              strokeWidth: 2,
              child: Container(
                height: screenSize.height * 0.2,
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.upload,
                        size: 40,
                        color: Color.fromARGB(255, 255, 207, 47),
                      ),
                      Text(
                        "Certificates",
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: Color.fromARGB(255, 2, 50, 10),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "You can upload any certificates you have here. Certificates increase your chances of getting hired",
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: Color.fromARGB(255, 2, 50, 10)),
                        textAlign: TextAlign.center,
                      )
                    ]),
              ),
            ),
            SizedBox(height: 40),
            Text(
              "Recent Work",
              style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Color.fromARGB(255, 2, 50, 10),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            widget.approved == "true"
                ? Image.asset(
                    "assets/images/worker_graphic.jpg",
                    width: screenSize.width * 0.6,
                  )
                : Expanded(
                    child: Center(
                    child: Text(
                        "Once you have been hired and start working your work history will show up here ",
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: Color.fromARGB(255, 2, 50, 10)),
                        textAlign: TextAlign.center),
                  )),
            Text(
                "Once you have been hired and start working your work history will show up here ",
                style: GoogleFonts.montserrat(
                    fontSize: 16, color: Color.fromARGB(255, 2, 50, 10)),
                textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
