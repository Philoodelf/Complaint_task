import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Description extends StatefulWidget {
  final String title;
  const Description({
    super.key,
    required this.title,
  });

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  FilePickerResult? result;
  bool showOptions = false;
  String fileName = "No file selected";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Submit a Complaint ',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Description',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                  ),
                  // minLines: 1, // Set this
                  maxLines: null, // and this
                  expands: true,
                  keyboardType: TextInputType.multiline,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, top: 8),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () async {
                        result = await FilePicker.platform.pickFiles();
                        if (result == null) {
                          print("No file selected");
                        } else {
                          setState(() {
                            fileName = result!.files.first.name;
                          });
                          for (var element in result!.files) {
                            print(element.name);
                          }
                        }
                      },
                      icon: const Icon(Icons.attach_file),
                    ),
                  ),
                  Align(alignment: Alignment.centerRight, child: Text(fileName)),
                ],
              ),
            ),
            // const SizedBox(height: 10),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: Text(fileName)),
            TextButton(
              onPressed: () {
                setState(() {
                  showOptions = !showOptions; // Toggle visibility
                });
              },
              child: Text(showOptions ? "Hide Options" : "Show Options"),
            ),
            const SizedBox(
              height: 10,
            ),
            Visibility(
              visible: showOptions,
              child: const Column(
                children: [Text(' options ')],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
