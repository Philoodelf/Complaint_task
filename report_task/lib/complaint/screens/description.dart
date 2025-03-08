import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:report_task/complaint/wigets/mytextfield.dart';
import 'package:report_task/cubit/usercubit.dart';

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
  String fileName = 'filename';
  String ?selectedCategory;

  Radiobuttons? _character = Radiobuttons.keep;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'appbarText'.tr(),
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Toggle between Arabic and English
              if (context.locale == const Locale('en')) {
                context.setLocale(const Locale('ar')); // Switch to Arabic
              } else {
                context.setLocale(const Locale('en')); // Switch to English
              }
            },
            child: Text(
              context.locale == const Locale('en')
                  ? '🇪🇬 عربي'
                  : '🇬🇧 English',
              style: const TextStyle(
                  color: Color.fromARGB(255, 43, 20, 255), fontSize: 16),
            ),
          ),
        ],
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
                    labelText: 'Description'.tr(),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 12),
                  ),
                  // minLines: 1, // Set this
                  maxLines: null, // and this
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  //textAlign: TextAlign.right,
                  textAlignVertical: TextAlignVertical.top,
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
                      alignment: Alignment.centerRight,
                      child: Text(fileName).tr()),
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
                child:
                    Text(showOptions ? 'hideOption'.tr() : 'showOption'.tr()),
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
                    variable: 'subject'.tr(),
                    controller: subjectcontoller,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Category'.tr(),
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
                      onChanged: (value) {
                        setState(() {
                          selectedCategory=value;
                        });
                      },
                    ),
                  ),
                  Column(
                    children: [
                      RadioListTile<Radiobuttons>(
                        title: const Text('keep').tr(),
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
                        title: const Text('add').tr(),
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
                        variable: 'name'.tr(),
                        controller: nameinputcontroller,
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 24),

                      //email
                      Mytextfield(
                        variable: 'email'.tr(),
                        controller: emailcontoller,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      //mobile number
                      Mytextfield(
                        variable: 'mobile'.tr(),
                        controller: numbercontoller,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 24),

                      //textnote
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                Colors.lightBlue[100], // Light blue background
                            borderRadius:
                                BorderRadius.circular(15), // Rounded corners
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Aligns text properly
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, // Aligns text at the top
                                children: [
                                  Icon(Icons.notes_rounded,
                                      color: Colors.lightBlue[700],
                                      size: 24), // Darker blue icon
                                  const SizedBox(
                                      width: 10), // Space between icon and text
                                  Expanded(
                                    // Makes text wrap inside the Row
                                    child: Text(
                                      'noteText'.tr(), // Translatable text
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.shield,
                                      color: Colors.lightBlue[700],
                                      size: 24), // Darker blue icon
                                  const SizedBox(
                                      width: 10), // Space between icon and text
                                  Expanded(
                                    child: Text(
                                      'ProtectText'.tr(), // Translatable text
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 30),
              child: ElevatedButton(
                onPressed: () {

                  context.read<UserCubit>().postIt(result, selectedCategory);
                  // Add your action here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.lightBlue[500], // Light blue background
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32), // Rounded corners
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 30), // Button padding
                ),
                child: const Text(
                  'send',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white, // Text color
                  ),
                ).tr(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

enum Radiobuttons { keep, add }
