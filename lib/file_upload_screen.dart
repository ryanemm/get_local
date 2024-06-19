import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class FileUploadScreen extends StatefulWidget {
  @override
  _FileUploadScreenState createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  File? _document;
  List<File> documents = [];
  bool documentUploaded = false;
  String? filename;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    setState(() {
      if (result != null) {
        _document = File(result.files.single.path!);
        filename = result.files.single.name;
        documents.add(_document!);
        documentUploaded = true;
        print("Document added to list");
        print(documents.length);
      } else {
        print('No file selected.');
      }
    });
  }

  Future<void> _uploadFile() async {
    if (_document == null) return;

    final uri = Uri.parse('http://139.144.77.133/getLocalDemo/document_upload.php');
    final request = http.MultipartRequest('POST', uri);

    for (File document in documents) {
      request.files.add(await http.MultipartFile.fromPath('files[]', document.path));
    }
    //final request = http.MultipartRequest('POST', uri)
      //..files.add(await http.MultipartFile.fromPath('file', _document!.path));
    final response = await request.send();
    

    if (response.statusCode == 200) {
      print('Files uploaded successfully');
      //var data = json.decode(response.stream);
      print(response.stream.transform(utf8.decoder)
          .listen((data) {
            print(data);
          }));
      
    } else {
      print('File upload failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Upload Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _document == null ? Text('No file selected.') : Text(_document!.path.toString()),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickFile,
              child: Text('Pick File'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _uploadFile,
              child: Text('Upload File'),
            ),
          ],
        ),
      ),
    );
  }
}
