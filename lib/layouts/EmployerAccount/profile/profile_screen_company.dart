import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_local/models/bio.dart';
import 'package:get_local/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show post;

class ProfileScreenCompany extends StatefulWidget {
  final String companyName;
  final String service;
  final String email;
  final String id;
  final String address;
  const ProfileScreenCompany(
      {super.key,
      required this.companyName,
      required this.service,
      required this.email,
      required this.id,
      required this.address});

  @override
  State<ProfileScreenCompany> createState() => _ProfileScreenCompanyState();
}

class _ProfileScreenCompanyState extends State<ProfileScreenCompany> {
  File? _profilePic;
  String? profilePicName;
  String? id;
  String profilePicUrl = "";
  String? service;
  List<Bio> bios = [];
  final ImagePicker _picker = ImagePicker();
  TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    id = widget.id;
    service = widget.service;
    profilePicName = "company_$id\_profile_pic";
    profilePicUrl =
        "http://139.144.77.133/getLocalDemo/documents/company_$id\_profile_pic.jpg";
    super.initState();
  }

  Future<List<Bio>> getBio() async {
    print("getting bio ");
    try {
      const jsonEndpoint = "http://139.144.77.133/getLocalDemo/get_bio.php";

      final response = await post(
        Uri.parse(jsonEndpoint),
        body: {"companyId": widget.id},
      );
      switch (response.statusCode) {
        case 200:
          List bios = json.decode(response.body);
          //print(posts);

          var formatted = bios.map((bio) => Bio.fromJson(bio)).toList();
          //print(formatted);

          //print(formatted);

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

  Future updateBio() async {
    print("updating bio ");
    try {
      const jsonEndpoint = "http://139.144.77.133/getLocalDemo/update_bio.php";

      final response = await post(
        Uri.parse(jsonEndpoint),
        body: {"companyId": widget.id, "bio": bioController.text},
      );
      switch (response.statusCode) {
        case 200:
          print("Bio updated successfully");
          setState(() {});
        default:
          throw Exception(response.reasonPhrase);
      }
    } on Exception {
      print("Caught an exception: ");
      //return Future.error(e.toString());
      rethrow;
    }
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
          content: Text(
              'Would you like to pick a picture for your profile? We recommend using your company logo.'),
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

  void showBioDialog(BuildContext context) {
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
              Text('Update Company Bio'),
            ],
          ),
          titleTextStyle: GoogleFonts.montserrat(
              color: Color.fromARGB(255, 2, 50, 10),
              fontSize: 24,
              fontWeight: FontWeight.bold),
          content: TextFormField(
            autofocus: false,
            maxLines: null,
            controller: bioController,
            style: simpleTextStyle(Colors.black),
            decoration: textFieldInputDecoration(
                "Type new bio here",
                const Icon(
                  Icons.abc,
                  color: const Color.fromARGB(255, 19, 53, 61),
                )),
          ),
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
              onPressed: () async {
                await updateBio();
                bioController.clear();
                Navigator.of(context).pop();
              },
              child: Text(
                'Update',
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

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Kosi Connect",
                      style: GoogleFonts.montserrat(
                          color: Color.fromARGB(255, 2, 50, 10),
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 120,
                    ),
                  ],
                ),
                Expanded(child: Container()),
              ],
            ),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: Color.fromARGB(255, 236, 250, 236),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Color.fromARGB(255, 2, 36, 10),
                      ),
                      Text(
                        widget.address,
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Text(
                        " ⦿ $service ",
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    showBioDialog(context);
                  },
                  child: Icon(
                    Icons.edit,
                    color: Color.fromARGB(255, 0, 33, 7),
                  ),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder<List<Bio>>(
                  future: getBio(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      if (bios.isNotEmpty) {
                        return Container(
                          color: Colors.blue,
                        );
                      }
                    } else if (snapshot.hasData && snapshot.hasError == false) {
                      print("snapshot data :");
                      print(snapshot.data);
                      bios = snapshot.data!;
                      print("Snapshot contains data");

                      if (bios.isNotEmpty) {
                        return Text(
                          bios[0].bio,
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.justify,
                        );
                      }
                    }
                    return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child:
                            const Center(child: CircularProgressIndicator()));
                  },
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Color.fromARGB(255, 253, 242, 141)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Add photos",
                        style: GoogleFonts.montserrat(
                            color: Color.fromARGB(255, 2, 50, 10),
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.add)
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: Container(
                    height: screenSize.height * 0.20,
                    width: screenSize.height * 0.20,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage("assets/images/stone_crushing.jpg"),
                            fit: BoxFit.cover)),
                    child: Container(),
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: Container(
                    height: screenSize.height * 0.20,
                    width: screenSize.height * 0.20,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/filtering.jpeg"),
                            fit: BoxFit.cover)),
                    child: Container(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
