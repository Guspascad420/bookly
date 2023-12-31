import 'package:bookly/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
import 'controllers/auth_controller.dart';
import 'home_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController ac = Get.put(AuthController());

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text('Create your account',
                      style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onBackground)),
                  const SizedBox(height: 40),
                  TextField(
                    controller: ac.nameTextController,
                    style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    onChanged: (_) {
                      ac.setIsSignUpButtonEnabled();
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xFFCFCBC9)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(width: 1, color: Colors.blue),
                      ),
                      filled: true,
                      hintText: "Name",
                      hintStyle: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF847E7C)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 18),
                    ),
                  ),
                  Obx(() => ac.isEmailValid.value
                      ? const SizedBox()
                      : Container(
                          margin: const EdgeInsets.only(top: 7),
                          child: Text(
                            'Name must be filled',
                            textAlign: TextAlign.right,
                            style: GoogleFonts.inter(
                                fontSize: 12, color: Colors.red),
                          ))),
                  const SizedBox(height: 20),
                  TextField(
                    controller: ac.emailTextController,
                    style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    onChanged: (_) {
                      ac.setIsSignUpButtonEnabled();
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xFFCFCBC9)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(width: 1, color: Colors.blue),
                      ),
                      filled: true,
                      hintText: "Email",
                      hintStyle: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF847E7C)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 18),
                    ),
                  ),
                  Obx(() => ac.isEmailValid.value
                      ? const SizedBox()
                      : Container(
                          margin: const EdgeInsets.only(top: 7),
                          child: Text(
                            'Please input valid email',
                            textAlign: TextAlign.right,
                            style: GoogleFonts.inter(
                                fontSize: 12, color: Colors.red),
                          ))),
                  const SizedBox(height: 20),
                  TextField(
                    controller: ac.passwordTextController,
                    style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    onChanged: (_) {
                      ac.setIsSignUpButtonEnabled();
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xFFCFCBC9)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(width: 1, color: Colors.blue),
                      ),
                      filled: true,
                      hintText: "Password (minimal 8 karakter)",
                      hintStyle: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF847E7C)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 18),
                    ),
                  ),
                  Obx(() => ac.isPasswordValid.value
                      ? const SizedBox()
                      : Container(
                          margin: const EdgeInsets.only(top: 7),
                          child: Text(
                            'Please input valid password',
                            textAlign: TextAlign.right,
                            style: GoogleFonts.inter(
                                fontSize: 12, color: Colors.red),
                          ))),
                  const SizedBox(height: 20),
                  TextField(
                    controller: ac.passwordConfirmTextController,
                    style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    onChanged: (_) {
                      ac.setIsSignUpButtonEnabled();
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xFFCFCBC9)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(width: 1, color: Colors.blue),
                      ),
                      filled: true,
                      hintText: "Confirm Password",
                      hintStyle: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF847E7C)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 18),
                    ),
                  ),
                  const SizedBox(height: 35),
                  Center(
                      child: Obx(() => ElevatedButton(
                          onPressed: ac.isSignUpButtonEnabled.value ? () {
                            ac.handleSignUp();
                          } : null,
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 120, vertical: 15),
                              backgroundColor: Colors.blue),
                          child: Obx(() => ac.isLoading.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text('Sign Up',
                                  style: GoogleFonts.poppins(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ))))))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
