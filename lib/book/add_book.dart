import 'package:bookly/book/book_textfield.dart';
import 'package:bookly/controllers/add_book_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddBook extends StatelessWidget {
  const AddBook({super.key});

  @override
  Widget build(BuildContext context) {
    final AddBookController abc = Get.put(AddBookController());

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text(
            'Add new book',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600
            )
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bookTextField('ISBN', abc.isbnTextController),
                  bookTextField('Title', abc.titleTextController),
                  bookTextField('Subtitle', abc.subtitleTextController),
                  bookTextField('Author', abc.authorTextController),
                  const SizedBox(height: 20),
                  Text('Published date',
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600
                      )),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: abc.publishedDate.value ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2024),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Colors.blue
                              )
                            ),
                            child: child!,
                          );
                        }
                      ).then((date) {
                        abc.publishedDate.value = date!;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: const Color(0xFFCFCBC9))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() => Text(
                              abc.publishedDate.value == null ? 'Pick date' :
                              DateFormat("dd-MM-yyy")
                                  .format(abc.publishedDate.value!).toString(),
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600
                              )
                          )),
                          const Icon(Icons.calendar_today_outlined)
                        ],
                      ),
                    )
                  ),
                  bookTextField('Publisher', abc.publisherTextController),
                  bookTextField('Pages', abc.pagesTextController, TextInputType.number),
                  bookTextField('Description', abc.descriptionTextController,
                      TextInputType.multiline),
                  bookTextField('Website', abc.websiteTextController,
                      TextInputType.multiline),
                  const SizedBox(height: 25),
                  Center(
                    child: Obx(() => ElevatedButton(
                        onPressed: abc.isButtonEnabled.value ? () {
                          abc.handleSubmit();
                        } : null,
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 120, vertical: 15
                            ),
                            backgroundColor: Colors.blue
                        ),
                        child: abc.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text('Add book',
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ))
                    ))
                  ),
                  const SizedBox(height: 35),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}