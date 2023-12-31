import 'package:bookly/login_page.dart';
import 'package:bookly/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          Center(
            child: Image.asset('images/4886568.jpg', scale: 2.3)
          ),
          const SizedBox(height: 10),
          RichText(
              text: TextSpan(
                text: 'Book.',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(text: 'ly', style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                  ))
                ]
              )
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const SignUpPage())
                );
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 15
                  ),
                  backgroundColor: Colors.grey[200]
              ),
              child: Text(
                  'Create Account',
                  style: GoogleFonts.poppins(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue
                  )
              )
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LoginPage())
                );
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 100, vertical: 15
                  ),
                  backgroundColor: Colors.blue
              ),
              child: Text(
                  'Login',
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  )
              )
          ),
        ],
      ),
    );
  }

}