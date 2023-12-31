import 'package:bookly/controllers/profile_controller.dart';
import 'package:bookly/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/bottom_nav_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController pc = Get.put(ProfileController());
    GetStorage box = GetStorage();

    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        automaticallyImplyLeading: false
      ),
      bottomNavigationBar: BottomNavBar(context: context, currentIndex: 1),
      body: GetX<ProfileController>(
        init: pc,
        builder: (val) {
          if (!val.isLoading.value) {
            return Column(
              children: [
                const SizedBox(height: 20),
                const Center(
                  child: Icon(Icons.account_circle, size: 100)
                ),
                const SizedBox(height: 15),
                Text(val.userProfile.value.name,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 22,
                    )),
                Text(val.userProfile.value.email,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 16,
                    )),
                const SizedBox(height: 40),
                ElevatedButton(
                    onPressed: () {
                      pc.handleLogout();
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15
                        ),
                        backgroundColor: Colors.red
                    ),
                    child: Text('Log out',
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ))
                )
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      )
    );
  }

}