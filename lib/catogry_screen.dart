import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taskyfinaly/common/catogry_row.dart';
import 'package:taskyfinaly/common/text_Row.dart';

class CatogryScreen extends StatelessWidget {
  const CatogryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          row_text(
            textone: ' عنها؟',
            texttwo: "خدمة تبحث   ",
            onTap: () {},
            showall: false,
          ),
          SizedBox(
            height: 15,
          ),
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
    );
  }
}
