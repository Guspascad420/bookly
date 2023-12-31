import 'package:bookly/controllers/auth_controller.dart';
import 'package:bookly/home_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController ac = Get.put(AuthController());
    ac.setIsLoginButtonEnabled();
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
                'Log in to your account',
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onBackground
                  )
            ),
            const SizedBox(height: 40),
            TextField(
              controller: ac.emailTextController,
              style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black
              ),
              onChanged: (value) {
                ac.setIsLoginButtonEnabled();
              },
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(width: 1, color: Color(0xFFCFCBC9)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(width: 1, color: Colors.blue),
                ),
                filled: true,
                hintText: "Email",
                hintStyle: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF847E7C)
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: ac.passwordTextController,
              style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black
              ),
              obscureText: true,
              onChanged: (value) {
                ac.setIsLoginButtonEnabled();
              },
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(width: 1, color: Color(0xFFCFCBC9)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(width: 1, color: Colors.blue),
                ),
                filled: true,
                hintText: "Password",
                hintStyle: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF847E7C)
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              ),
            ),
            Obx(() => ac.isLoginSucceeded.value
                ? const SizedBox()
                : Container(
                      margin: const EdgeInsets.only(top: 7),
                      child: Text(
                        'Invalid Email/Password',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.inter(fontSize: 12, color: Colors.red),
                      )
                  )
            ),
            const SizedBox(height: 30),
            Center(
              child: Obx(() => ElevatedButton(
                  onPressed: ac.isLoginButtonEnabled.value ? () {
                    ac.handleLogin();
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
                  child: Obx(() => ac.isLoading.value
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                      'Login',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      )
                  ))
              ))
            )
          ],
        ),
      ),
    );
  }

}