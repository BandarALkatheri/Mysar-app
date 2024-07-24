import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:taskyfinaly/catagory/catagory_list.dart';
import 'package:taskyfinaly/common/catogry_row.dart';
import 'package:taskyfinaly/common/itemCardforOffer.dart';
import 'package:taskyfinaly/common/itemForCategory.dart';
import 'package:taskyfinaly/common/listViewBuliderForOffer.dart';
import 'package:taskyfinaly/common/text_Row.dart';
import 'package:taskyfinaly/offerModel.dart';
import 'package:taskyfinaly/provider/offerProvider.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  late List<offerModel> pagesOffer;
  int activePage = 0;
  bool isNoConaction = false;
  final PageController pageController = PageController(initialPage: 0);
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        if (pageController.page == pagesOffer.length - 1) {
          pageController.animateToPage(0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        } else {
          pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    final offersProdcut = Provider.of<Offerprovider>(context, listen: false);
    offersProdcut.fetchOffer();

    startTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final offersProdcut = Provider.of<Offerprovider>(context);

    final CarouselController controller = CarouselController();
    pagesOffer = Offerprovider.advaster;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // stack for slider
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 3,
                  child: PageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        activePage = value;
                      });
                    },
                    itemCount: pagesOffer.length,
                    controller: pageController,
                    itemBuilder: (context, index) {
                      return imagePaceHolder(
                        imagePath: pagesOffer[index].imageUrl,
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 0,
                  left: 0,
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          List<Widget>.generate(pagesOffer.length, (Index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: CircleAvatar(
                            radius: activePage == Index ? 5 : 4,
                            backgroundColor: activePage == Index
                                ? Colors.orange
                                : Colors.grey,
                          ),
                        );
                      }),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            row_text(
              textone: ' عنها؟',
              texttwo: "خدمة تبحث   ",
              onTap: () {},
              showall: false,
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                buildCategoryRow(context, [
                  {'icon': Icons.electrical_services, 'text': 'كهربائي'},
                  {'icon': Icons.ac_unit, 'text': 'تكييف وتبريد'},
                  {'icon': Icons.cleaning_services, 'text': 'تنظيف'},
                ]),
                const SizedBox(height: 10),
                buildCategoryRow(context, [
                  {'icon': Icons.build, 'text': 'سباك'},
                  {'icon': Icons.construction, 'text': 'انشائي'},
                  {'icon': Icons.handyman, 'text': 'نجار'},
                ]),
              ],
            ),
            const SizedBox(
              height: 25,
            ),

            row_text(
              textone: ' تكييف',
              texttwo: "فني   ",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CatagoryList(
                      offerprovider: offersProdcut,
                      category: 'Airconditioning',
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            listViewBuliderForOffer(
              category: 'Airconditioning',
              offerprovider: offersProdcut,
            ),
            const SizedBox(
              height: 30,
            ),
            row_text(
              textone: ' كهرباء',
              texttwo: "مهندسين   ",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CatagoryList(
                      offerprovider: offersProdcut,
                      category: 'Electricity',
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            listViewBuliderForOffer(
              category: 'Electricity',
              offerprovider: offersProdcut,
            ),
            const SizedBox(
              height: 30,
            ),

            row_text(
              textone: ' نظافة',
              texttwo: "خدمات   ",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CatagoryList(
                      offerprovider: offersProdcut,
                      category: 'Cleaning',
                    ),
                  ),
                );
              },
            ),

            const SizedBox(
              height: 20,
            ),
            listViewBuliderForOffer(
              category: 'Cleaning',
              offerprovider: offersProdcut,
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class imagePaceHolder extends StatelessWidget {
  final String? imagePath;
  const imagePaceHolder({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          imagePath!,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
