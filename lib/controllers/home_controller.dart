import 'package:bookly/models/book.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  final dio = Dio();
  GetStorage box = GetStorage();
  RxList<Book> bookList = <Book>[].obs;

  void retrieveBooks() async {
    isLoading.value = true;
    var token = box.read("token");
    var response = await dio.get(
      'https://book-crud-service-6dmqxfovfq-et.a.run.app/api/books',
      options: Options(
        headers: {
          Headers.acceptHeader: 'application/json',
          "Authorization": "Bearer $token"
        }
      )
    );
    if (response.statusCode == 200) {
      List<dynamic> rawList = response.data["data"];
      bookList.assignAll(rawList.map((bookMap) => Book.fromMap(bookMap as Map<String, dynamic>)));
    }
    isLoading.value = false;
  }
}