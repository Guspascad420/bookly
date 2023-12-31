import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class AddBookController extends GetxController {
  final TextEditingController isbnTextController = TextEditingController();
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController subtitleTextController = TextEditingController();
  final TextEditingController authorTextController = TextEditingController();
  final TextEditingController publisherTextController = TextEditingController();
  final TextEditingController pagesTextController = TextEditingController();
  final TextEditingController descriptionTextController = TextEditingController();
  final TextEditingController websiteTextController = TextEditingController();

  var isLoading = false.obs;
  var publishedDate = Rxn<DateTime>();
  var isButtonEnabled = false.obs;
  final dio = Dio();
  GetStorage box = GetStorage();

  void setIsButtonEnabled() {
    if (isbnTextController.text.isNotEmpty && titleTextController.text.isNotEmpty
    && subtitleTextController.text.isNotEmpty && publishedDate.value != null
        && authorTextController.text.isNotEmpty
        && publisherTextController.text.isNotEmpty && pagesTextController.text.isNotEmpty
    && descriptionTextController.text.isNotEmpty && websiteTextController.text.isNotEmpty) {
      isButtonEnabled.value = true;
    } else {
      isButtonEnabled.value = false;
    }
  }

  void handleSubmit() {
    var token = box.read("token");
    setIsLoading();
    dio.post(
        'https://book-crud-service-6dmqxfovfq-et.a.run.app/api/books/add',
        options: Options(
            validateStatus: (_) => true,
            headers: {
              Headers.acceptHeader: 'application/json',
              'Authorization': 'Bearer $token'
            }
        ),
        data: {
          "isbn": isbnTextController.text,
          "title": titleTextController.text,
          "subtitle": subtitleTextController.text,
          "author": authorTextController.text,
          "published": DateFormat("yyyy-MM-dd HH:mm:ss")
              .format(publishedDate.value!).toString(),
          "publisher": publisherTextController.text,
          "pages": int.parse(pagesTextController.text),
          "description": descriptionTextController.text,
          "website": websiteTextController.text
        }
    ).then((response) {
      if (response.statusCode == 200) {
        Get.back();
      } else {
        Get.showSnackbar(
          GetSnackBar(
            title: "Error",
            message: response.data["message"],
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
      setIsLoading();
    });
  }


  setIsLoading() => isLoading.value = !isLoading.value;
}