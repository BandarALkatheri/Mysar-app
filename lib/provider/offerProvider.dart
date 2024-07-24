import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taskyfinaly/offerModel.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taskyfinaly/offerModel.dart';

class Offerprovider with ChangeNotifier {
  static final List<offerModel> offerList = [];
  static final List<offerModel> Electricity = [];
  static final List<offerModel> Airconditioning = [];
  static final List<offerModel> Cleaning = [];
  static final List<offerModel> empty = [];
  static final List<offerModel> advaster = [];

  List<offerModel> get getElectricity {
    return Electricity;
  }

  List<offerModel> get getadvaster {
    return Electricity;
  }

  List<offerModel> get getempty {
    return Electricity;
  }

  List<offerModel> get getOffer {
    return offerList;
  }

  List<offerModel> get getAirconditioning {
    return Airconditioning;
  }

  List<offerModel> get getCleaning {
    return Cleaning;
  }

  void fetchOffer() async {
    try {
      final offers =
          await FirebaseFirestore.instance.collection('prodcut').get();
      offerList.clear();
      Electricity.clear();
      Airconditioning.clear();
      Cleaning.clear();
      advaster.clear();

      for (var element in offers.docs) {
        // Create an offerModel instance from Firestore document
        offerModel offer = offerModel(
          offerId: element.get('uuid'),
          title: element.get('title'),
          description: element.get('description'),
          price: element.get('price'),
          location: element.get('location'),
          fullDescription: element.get('fullDescription'),
          category: element.get('category'),
          imageUrl: element.get('imageurl'),
        );

        // Add offer to the main list
        offerList.add(offer);

        // Categorize the offer based on 'category' field
        switch (offer.category) {
          case 'Electricity':
            Electricity.add(offer);
            break;
          case 'Cleaning':
            Cleaning.add(offer);
            break;
          case 'Airconditioning':
            Airconditioning.add(offer);
            break;
          case 'advaster':
            advaster.add(offer);
            break;
          // Add more cases for other categories if needed
        }
      }

      notifyListeners();
    } catch (error) {
      print('Error fetching offers: $error');
      // Handle errors as needed
    }
  }
}
