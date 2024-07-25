import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get_local/components/gradient_button.dart';
import 'package:get_local/models/post.dart';
import 'package:get_local/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' show post;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

class NewPostScreen extends StatefulWidget {
  String? companyName;
  String? companyId;

  NewPostScreen({super.key, this.companyId, this.companyName});

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  TextEditingController contentController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  String? companyId;
  String? postTitleImage;
  File? titlePic;
  String? fileExtension;
  final ImagePicker _picker = ImagePicker();

  @override
  initState() {
    companyId = widget.companyId;
    super.initState();
  }

  Future addPost() async {
    var url = "http://139.144.77.133/getLocalDemo/add_post.php";
    var response = await post(Uri.parse(url), body: {
      "company": widget.companyName,
      "companyId": widget.companyId,
      "title": titleController.text,
      "content": contentController.text,
    });

    if (response.statusCode == 200) {
      List posts = json.decode(response.body);
      var formatted = posts.map((post) => Post.fromJson(post)).toList();
      String id = formatted[0].id;

      postTitleImage = "company_$companyId\_post_$id";
      await uploadTitlePic(titlePic!, postTitleImage! + fileExtension!);
      print("Post added successfully!");
      showToast("Post Sent Successfully!");
      Navigator.pop(context);
    } else {
      print("An error occured please try again");
    }
  }

  Future<void> uploadTitlePic(File file, String newName) async {
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

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Use the image
      setState(() {
        print('Image path: ${image.path}');
        titlePic = File(image.path);
        fileExtension = path.extension(titlePic!.path);
        print("File extension: $fileExtension");
      });
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Color.fromARGB(255, 22, 44, 49),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  print("Back button tapped");
                  Navigator.pop(context);
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Color.fromARGB(84, 148, 147, 147)),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Text(
                "New Post",
                style: GoogleFonts.montserrat(
                    fontSize: 24,
                    color: Color.fromARGB(255, 2, 50, 10),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 32),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(32)),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(4, 7),
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ]),
            child: TextFormField(
              autofocus: false,
              maxLines: null,
              controller: titleController,
              style: simpleTextStyle(Colors.black),
              decoration: textFieldInputDecoration(
                  "Title",
                  const Icon(
                    Icons.abc,
                    color: const Color.fromARGB(255, 19, 53, 61),
                  )),
            ),
          ),
          SizedBox(height: 32),
          GestureDetector(
            onTap: () {
              pickImage();
            },
            child: titlePic == null
                ? DottedBorder(
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
                              Icons.image,
                              size: 40,
                              color: Color.fromARGB(255, 255, 207, 47),
                            ),
                            Text(
                              "Image",
                              style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 2, 50, 10),
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Select an image for your post",
                              style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 2, 50, 10)),
                              textAlign: TextAlign.center,
                            )
                          ]),
                    ),
                  )
                : Container(
                    height: screenSize.height * 0.2,
                    width: double.infinity,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(color: Colors.grey)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Image.file(
                        titlePic!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
          ),
          SizedBox(height: 32),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(32)),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(4, 7),
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ]),
            child: TextFormField(
              autofocus: false,
              maxLines: null,
              controller: contentController,
              style: simpleTextStyle(Colors.black),
              decoration: textFieldInputDecoration(
                  "Post",
                  const Icon(
                    Icons.text_snippet,
                    color: const Color.fromARGB(255, 19, 53, 61),
                  )),
            ),
          ),
          SizedBox(height: 32),
          Expanded(child: Container()),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GradientButton(
                function: () async {
                  await addPost();
                },
                buttonColor1: Color.fromARGB(255, 253, 228, 0),
                buttonColor2: Color.fromARGB(255, 194, 176, 9),
                shadowColor: Colors.grey.shade500,
                offsetX: 4,
                offsetY: 4,
                text: "Post",
                width: 100.00,
                textColor: const Color.fromARGB(255, 19, 53, 61),
              ),
              SizedBox(height: 200)
            ],
          ),
        ],
      ),
    );
  }
}
