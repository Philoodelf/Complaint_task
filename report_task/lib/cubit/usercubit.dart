import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:report_task/core/api/api_consumer.dart';
import 'package:report_task/core/api/end_points.dart';
import 'package:report_task/complaint/screens/description.dart';
import 'package:report_task/cubit/userstate.dart';
//import '../../cubit/userState.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.api) : super(UserInitial());
  final ApiConsumer api;

  GlobalKey<FormState> sendItFormKey = GlobalKey();

  TextEditingController nameinputcontroller = TextEditingController();
  TextEditingController subjectcontoller = TextEditingController();
  TextEditingController emailcontoller = TextEditingController();
  TextEditingController numbercontoller = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController fileController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  Future<void> postIt(dynamic result, dynamic selectedCategory) async {
    try {
      emit(PostLoading());
      late File file;
      String fileName = "";
      if (result != null && result!.files.isNotEmpty) {
        file = File(result!.files.single.path!); // Get the picked file
        fileName = result!.files.single.name; // Get file name
      }
        //api.post(EndPoints.postComplaint,
        FormData formData = FormData.fromMap({
          ApiKeys.description: descriptionController.text,
          ApiKeys.subject: subjectcontoller.text,
          ApiKeys.name: nameinputcontroller.text,
          ApiKeys.email: emailcontoller.text,
          ApiKeys.phone: numbercontoller.text,
       if (fileName.isNotEmpty)   ApiKeys.file: await MultipartFile.fromFile(file.path,filename: fileName), // ✅ File upload
          ApiKeys.category:selectedCategory, // ✅ Ensure you have a selectedCategory variable
        });

        Response? response = await api.post(EndPoints.postComplaint, data: formData);
        if (response!.statusCode == 200) {
          print("✅ Complaint submitted successfully!");
          emit(SendSuccess());
          await Future.delayed(const Duration(seconds: 2));
          emit(UserInitial());
        } else {
          print("⚠️ Failed to submit complaint: ${response.statusMessage}");
        }
      
    } on Exception catch (e) {
      print("❌ Error posting complaint: $e");
      //emit(SendFailure(errMessage: ));
    }

    // api.post(EndPoints.postComplaint, data: {
    //   ApiKeys.description: descriptionController.text,
    //   ApiKeys.subject: subjectcontoller.text,
    //   ApiKeys.name: nameinputcontroller.text,
    //   ApiKeys.email: emailcontoller.text,
    //   ApiKeys.phone: numbercontoller.text,
    //   ApiKeys.file: fileController.,
    //   ApiKeys.category: categoryController.selection
    // });
    // try{
    // final response = await api.post(

    // );
    // emit(SendSuccess());
    // print(response);

    // }catch(e){
    //   emit(SendFailure(errMessage: e.toString()));
    //   print(e.toString());

    // }
  }
  //);
}
