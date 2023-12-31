import 'package:bookly/book/add_book.dart';
import 'package:bookly/book/book_card.dart';
import 'package:bookly/components/bottom_nav_bar.dart';
import 'package:bookly/controllers/home_controller.dart';
import 'package:bookly/utils/static_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController hc = Get.put(HomeController());
    WidgetsBinding.instance.addPostFrameCallback((_){
      hc.retrieveBooks();
    });
    return Scaffold(
        appBar: AppBar(
          title: Text('My Books',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => const AddBook());
                },
                icon: const Icon(Icons.add, size: 30)
            )
          ],
        ),
        bottomNavigationBar: BottomNavBar(context: context, currentIndex: 0),
        body: GetX<HomeController>(
          init: hc,
          builder: (val) {
            if (!val.isLoading.value) {
              if (val.bookList.isEmpty) {
                return Center(
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                        Image.asset('images/empty-box.png', scale: 2.5),
                        Text('There are no books here..',
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.onBackground))
                      ],
                ));
              }
              return Column(
                children: [
                  const SizedBox(height: 20),
                  StaticGrid(
                      gap: 4,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      children: [
                        for (var book in val.bookList)
                          bookCard(context, book)
                      ])
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        )
    );
  }
}
