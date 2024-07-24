import 'package:flutter/material.dart';
import 'package:taskyfinaly/common/itemCardforOffer.dart';
import 'package:taskyfinaly/offerModel.dart';
import 'package:taskyfinaly/provider/offerProvider.dart';

class CatagoryList extends StatelessWidget {
  final Offerprovider offerprovider;
  final String category;

  const CatagoryList(
      {super.key, required this.offerprovider, required this.category});

  @override
  Widget build(BuildContext context) {
    List<offerModel> offers = [];
    bool isEmpty = false;

    // Determine which category to display
    switch (category) {
      case 'Electricity':
        offers = offerprovider.getElectricity;
        break;
      case 'Airconditioning':
        offers = offerprovider.getAirconditioning;
        break;
      case 'Cleaning':
        offers = offerprovider.getCleaning;
        break;
      default:
        isEmpty = true;
        offers = offerprovider.getOffer; // Default to general offers
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category.toString(),
          style: const TextStyle(color: Colors.orange),
        ),
      ),
      body: isEmpty
          ? const Center(
              child: Text(
              'لايوجد خدمات يتم عرضها',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Helvetica',
                fontSize: 18,
                color: Colors.orange,
              ),
            ))
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.90,
              ),
              itemCount: offers.length,
              itemBuilder: (context, index) {
                final offer = offers[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: itemCardforOffer(
                    prices: offer.price.toString(),
                    dec: offer.description.toString(),
                    location: offer.location.toString(),
                    imageUrl: offer.imageUrl.toString(),
                    fullDescription: offer.fullDescription.toString(),
                    title: offer.title.toString(),
                  ),
                );
              },
            ),
    );
  }
}
