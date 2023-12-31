import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/add_book_controller.dart';

Widget bookTextField(String title, TextEditingController controller, [TextInputType? textInputType]) {
  final AddBookController abc = Get.put(AddBookController());
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      const SizedBox(height: 20),
      Text(title,
          style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600
          )),
      const SizedBox(height: 5),
      TextField(
        controller: controller,
        style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black
        ),
        onChanged: (value) {
          abc.setIsButtonEnabled();
        },
        keyboardType: textInputType ?? TextInputType.text,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(width: 1, color: Color(0xFFCFCBC9)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(width: 1, color: Colors.blue),
          ),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),
    ],
  );
}