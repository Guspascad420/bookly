import 'package:bookly/book/book_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/book.dart';

Widget bookCard(BuildContext context, Book book) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => BookDetails(book: book))
      );
    },
    child: Card(
      surfaceTintColor: Theme.of(context).colorScheme.background,
      color: Theme.of(context).colorScheme.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        //set border radius more than 50% of height and width to make circle
      ),
      child: Container(
        width: 145,
        margin: const EdgeInsets.all(14),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            Center(
              child: Image.asset('images/sample_cover.png', scale: 5)
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(book.title,
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onBackground
                  )),
            )
          ],
        ),
      ),
    ),
  );
}