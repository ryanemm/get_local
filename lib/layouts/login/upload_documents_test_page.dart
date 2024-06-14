import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UploadDocumentsTestPage extends StatelessWidget {
  Future<void> _uploadDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'doc',
        'docx',
        'txt'
      ], // Add more extensions as needed
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      String fileName = result.files.single.name;

      // API endpoint for file upload
      var url =
          Uri.parse('http://139.144.77.133/getLocalDemo/document_upload.php');

      // Create multipart request for file upload
      var request = http.MultipartRequest('POST', url);
      request.files.add(http.MultipartFile.fromBytes(
        'file',
        await file.readAsBytes(),
        filename: fileName,
      ));

      try {
        var streamedResponse = await request.send();
        if (streamedResponse.statusCode == 200) {
          print('File uploaded successfully');
          print(streamedResponse.stream);
        } else {
          print(streamedResponse.statusCode);
          print('Failed to upload file');
        }
      } catch (e) {
        print('Error uploading file: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Document')),
      body: Center(
        child: ElevatedButton(
          onPressed: _uploadDocument,
          child: Text('Select Document to Upload'),
        ),
      ),
    );
  }
}
