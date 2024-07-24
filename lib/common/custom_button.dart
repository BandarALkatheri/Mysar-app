import 'package:flutter/material.dart';
import 'dart:core';


class custom_Button extends StatelessWidget {
  const custom_Button({super.key, 
    required this.text,
    required this.onPressed,
  });

  final text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontFamily: 'Helvetica'),
          ),
        ),
      ),
    );
  }
}
