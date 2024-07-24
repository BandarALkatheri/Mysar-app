import 'package:flutter/material.dart';

Widget itemForCategory(
    {required IconData iconData,
    required String text,
    required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 26, 0.1),
          blurRadius: 0,
          spreadRadius: 0.5,
          offset: Offset(
            0,
            1,
          ),
        ),
      ], borderRadius: BorderRadius.circular(16), color: Colors.white38),
      height: 100,
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData, size: 40, color: Colors.orange),
          const SizedBox(height: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
}
