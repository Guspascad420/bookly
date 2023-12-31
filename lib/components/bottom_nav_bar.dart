import 'package:bookly/home_page.dart';
import 'package:bookly/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavBar extends StatelessWidget {
  final BuildContext context;
  final int currentIndex;

  const BottomNavBar({super.key, required this.context, required this.currentIndex});

  void onItemTapped(int index) {
    if (index == 0) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => const HomePage()
          )
      );
    } else if (index == 1) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => const ProfilePage()
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38, spreadRadius: 0, blurRadius: 7),
          ],
          color: Theme.of(context).colorScheme.background
      ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            showUnselectedLabels: true,
            selectedLabelStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground
            ),
            unselectedLabelStyle: GoogleFonts.poppins(
                color: Colors.grey[500]
            ),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile'
              )
            ],
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey[500],
            currentIndex: currentIndex,
            onTap: onItemTapped,
          ),
        )
    );
  }
}