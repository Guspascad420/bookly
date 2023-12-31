import 'package:bookly/home_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../models/book.dart';

class EditBookController extends GetxController {
  final TextEditingController isbnTextController = TextEditingController();
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController subtitleTextController = TextEditingController();
  final TextEditingController authorTextController = TextEditingController();
  final TextEditingController publisherTextController = TextEditingController();
  final TextEditingController pagesTextController = TextEditingController();
  final TextEditingController descriptionTextController = TextEditingController();
  final TextEditingController websiteTextController = TextEditingController();

  var publishedDate = Rxn<DateTime>();
  var isButtonEnabled = false.obs;
  var isLoading = false.obs;

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

  void initValues(Book book) {
    isbnTextController.text = book.isbn;
    titleTextController.text = book.title;
    subtitleTextController.text = book.subtitle;
    authorTextController.text = book.author;
    publisherTextController.text = book.publisher;
    pagesTextController.text = book.pages.toString();
    descriptionTextController.text = book.description;
    websiteTextController.text = book.website;
    publishedDate.value = DateTime.parse(book.published);
  }

  void handleEdit(int id) {
    var token = box.read("token");
    setIsLoading();
    dio.put(
        'https://book-crud-service-6dmqxfovfq-et.a.run.app/api/books/$id}/edit',
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
        Get.offAll(const HomePage());
      }
      setIsLoading();
    });
  }

  void deleteBook(int id) {
    var token = box.read("token");
    setIsLoading();
    dio.delete(
        'https://book-crud-service-6dmqxfovfq-et.a.run.app/api/books/$id',
        options: Options(
            validateStatus: (_) => true,
            headers: {
              Headers.acceptHeader: 'application/json',
              'Authorization': 'Bearer $token'
            }
        )
    ).then((response) {
      if (response.statusCode == 200) {
        Get.offAll(const HomePage());
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