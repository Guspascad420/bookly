import 'package:bookly/book/edit_book.dart';
import 'package:bookly/controllers/edit_book_controller.dart';
import 'package:bookly/models/book.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class BookDetails extends StatelessWidget {
  const BookDetails({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    final EditBookController ebc = EditBookController();

    void openDialog() {
      Get.dialog(
          AlertDialog(
            surfaceTintColor: Theme.of(context).colorScheme.background,
            actionsAlignment: MainAxisAlignment.spaceBetween,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.warning_amber, size: 150),
                Text('Are you sure? This action cannot be undone',
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onBackground))
              ],
            ),
            actions: <Widget>[
              // const Color(0xFF314797)
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4)),
                  child: Text('No',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))
              ),
              ElevatedButton(
                  onPressed: () {
                    ebc.deleteBook(book.id);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4)),
                  child: Text('Yes',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.background))
              )
            ],
          )
      );
    }

    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditBook(book: book))
                  );
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 12
                    ),
                    backgroundColor: Colors.blue
                ),
                child: Text('Edit',
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ))
            ),
            const SizedBox(width: 20),
            ElevatedButton(
                onPressed: openDialog,
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 12
                    ),
                    backgroundColor: Colors.red
                ),
                child: Text('Delete',
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ))
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Image.asset('images/sample_cover.png', scale: 2.5)
              ),
              const SizedBox(height: 15),
              Text(book.title,
                  style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onBackground
                  )),
              Text(book.subtitle,
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onBackground
                  )),
              RichText(
                  text: TextSpan(
                      text: 'By ',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(text: book.author, style: GoogleFonts.poppins(
                            color: Colors.blue
                        ))
                      ]
                  )
              ),
              const SizedBox(height: 30),
              Text('Book description',
                  style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onBackground
                  )),
              Text(book.description,
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onBackground
                  )),
              const SizedBox(height: 20),
              Text('Book info',
                  style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onBackground
                  )),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Publish date',
                      style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onBackground
                      )),
                  Text(book.published.substring(0, 10),
                      style: GoogleFonts.poppins(
                          fontSize: 17,
                          color: Theme.of(context).colorScheme.onBackground
                      )),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Pages length',
                      style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onBackground
                      )),
                  Text("${book.pages}",
                      style: GoogleFonts.poppins(
                          fontSize: 17,
                          color: Theme.of(context).colorScheme.onBackground
                      )),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Website',
                      style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onBackground
                      )),
                  Text(book.website,
                      style: GoogleFonts.poppins(
                          fontSize: 17,
                          color: Theme.of(context).colorScheme.onBackground
                      )),
                ],
              ),
            ],
          ),
        )
      )
    );
  }

}