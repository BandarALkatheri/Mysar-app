import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:taskyfinaly/catagory/catagory_list.dart';
import 'package:taskyfinaly/common/itemForCategory.dart';
import 'package:taskyfinaly/provider/offerProvider.dart';

Row buildCategoryRow(
    BuildContext context, List<Map<String, dynamic>> categories) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: categories
        .map((category) => itemForCategory(
              iconData: category['icon'],
              text: category['text'],
              onTap: () {
                handleCategoryTap(context, category['text']);
              },
            ))
        .toList(),
  );
}

void handleCategoryTap(BuildContext context, String category) {
  final offersProdcut = Provider.of<Offerprovider>(context, listen: false);

  switch (category) {
    case 'كهربائي':
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CatagoryList(
            offerprovider: offersProdcut,
            category: 'Electricity',
          ),
        ),
      );
      break;
    case 'تكييف وتبريد':
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CatagoryList(
            offerprovider: offersProdcut,
            category: 'Airconditioning',
          ),
        ),
      );
      break;
    case 'تنظيف':
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CatagoryList(
            offerprovider: offersProdcut,
            category: 'Cleaning',
          ),
        ),
      );
      break;
    case 'سباك':
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CatagoryList(
            offerprovider: offersProdcut,
            category: 'Plumbing',
          ),
        ),
      );
      break;
    case 'انشائي':
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CatagoryList(
            offerprovider: offersProdcut,
            category: 'Construction',
          ),
        ),
      );
      break;
    case 'نجار':
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CatagoryList(
            offerprovider: offersProdcut,
            category: 'Carpenter',
          ),
        ),
      );

      // منطق التعامل مع نجار
      break;
    default:
      print('تصنيف غير معروف: $category');
  }
}
