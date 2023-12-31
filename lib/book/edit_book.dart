import 'package:bookly/controllers/edit_book_controller.dart';
import 'package:bookly/models/book.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'book_textfield.dart';

class EditBook extends StatelessWidget {
  const EditBook({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    final EditBookController ebc = Get.put(EditBookController());

    ebc.initValues(book);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text(
            'Edit book',
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
                  bookTextField('ISBN', ebc.isbnTextController),
                  bookTextField('Title', ebc.titleTextController),
                  bookTextField('Subtitle', ebc.subtitleTextController),
                  bookTextField('Author', ebc.authorTextController),
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
                            initialDate: ebc.publishedDate.value ?? DateTime.now(),
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
                          ebc.publishedDate.value = date!;
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
                                ebc.publishedDate.value == null ? 'Pick date' :
                                DateFormat("dd-MM-yyy")
                                    .format(ebc.publishedDate.value!).toString(),
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600
                                )
                            )),
                            const Icon(Icons.calendar_today_outlined)
                          ],
                        ),
                      )
                  ),
                  bookTextField('Publisher', ebc.publisherTextController),
                  bookTextField('Pages', ebc.pagesTextController, TextInputType.number),
                  bookTextField('Description', ebc.descriptionTextController,
                      TextInputType.multiline),
                  bookTextField('Website', ebc.websiteTextController,
                      TextInputType.multiline),
                  const SizedBox(height: 25),
                  Center(
                      child: Obx(() => ElevatedButton(
                          onPressed: () {
                            ebc.handleEdit(book.id);
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 120, vertical: 15
                              ),
                              backgroundColor: Colors.blue
                          ),
                          child: ebc.isLoading.value
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : Text('Edit book',
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