import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:report_task/complaint/wigets/mytextfield.dart';

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
  final nameinputcontroller = TextEditingController();
  final subjectcontoller = TextEditingController();
  final emailcontoller = TextEditingController();
  final numbercontoller = TextEditingController();

  FilePickerResult? result;
  bool showOptions = false;
  bool showContact = false;
  String fileName = "No file selected";

  Radiobuttons? _character = Radiobuttons.keep;

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
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 12),
                  ),
                  // minLines: 1, // Set this
                  maxLines: null, // and this
                  expands: true,
                  keyboardType: TextInputType.multiline,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 16,
              ),
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
                  Align(
                      alignment: Alignment.centerRight, child: Text(fileName)),
                ],
              ),
            ),
            // const SizedBox(height: 10),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: Text(fileName)),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    showOptions = !showOptions; // Toggle visibility
                  });
                },
                child: Text(showOptions ? "Hide Options" : "Show Options"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Visibility(
              visible: showOptions,
              child: Column(
                children: [
                  Mytextfield(
                    variable: 'Subject',
                    controller: subjectcontoller,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Category',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        fillColor: const Color.fromARGB(150, 238, 238, 238),
                        filled: true,
                      ),
                      items: <String>['A', 'B', 'C', 'D'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                  Column(
                    children: [
                      RadioListTile<Radiobuttons>(
                        title: const Text('Keep Anonymous'),
                        value: Radiobuttons.keep,
                        groupValue: _character,
                        onChanged: (Radiobuttons? value) {
                          setState(() {
                            _character = value;
                            showContact = false;
                          });
                        },
                      ),
                      RadioListTile<Radiobuttons>(
                        title: const Text('Add Contact Information'),
                        value: Radiobuttons.add,
                        groupValue: _character,
                        onChanged: (Radiobuttons? value) {
                          setState(() {
                            _character = value;
                            showContact = !showContact;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //new visibility
            Column(
              children: [
                Visibility(
                  visible: showContact,
                  child: Column(
                    children: [
                      //name
                      Mytextfield(
                        variable: 'Name',
                        controller: nameinputcontroller,
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 24),

                      //email
                      Mytextfield(
                        variable: 'Email',
                        controller: emailcontoller,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      //mobile number
                      Mytextfield(
                        variable: 'Mobile Number',
                        controller: numbercontoller,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum Radiobuttons { keep, add }
