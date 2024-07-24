import 'package:flutter/material.dart';
import 'package:taskyfinaly/common/itemCardforOffer.dart';
import 'package:taskyfinaly/offerModel.dart';
import 'package:taskyfinaly/provider/offerProvider.dart';

class listViewBuliderForOffer extends StatelessWidget {
  final Offerprovider offerprovider;
  final String category;

  listViewBuliderForOffer(
      {required this.offerprovider, required this.category});

  @override
  Widget build(BuildContext context) {
    List<offerModel> offers = [];

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
        offers = offerprovider.getOffer; // Default to general offers
    }

    final limitedOffers = offers.take(10).toList();
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: limitedOffers.length,
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
