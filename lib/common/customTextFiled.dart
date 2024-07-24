import 'package:flutter/material.dart';
import 'dart:core';

class customTextFiled extends StatefulWidget {
  customTextFiled(
      {super.key,
      this.onChanged,
      required this.labltext,
      this.keyboardType = false,
      required this.iconData,
      this.isPassword = false,
      required this.validator});

  var labltext;
  final IconData iconData;
  final bool keyboardType;
  Function(String)? onChanged;
  final String? Function(String?)? validator;
  bool isPassword;
  bool showOrnot = false;

  @override
  State<customTextFiled> createState() => _customTextFiledState();
}

class _customTextFiledState extends State<customTextFiled> {
  bool showOrnot = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        keyboardType: widget.keyboardType ? TextInputType.number : null,
        validator: widget.validator,
        onChanged: widget.onChanged,
        obscureText: widget.isPassword && !showOrnot,
        autofocus: false,
        style: const TextStyle(fontSize: 22.0, color: Colors.black),
        decoration: InputDecoration(
          labelText: widget.labltext.toString(),
          labelStyle: const TextStyle(
            fontFamily: 'Helvetica',
          ),
          suffixIcon: Icon(
            widget.iconData,
            size: 20,
          ),
          prefixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      print(showOrnot);
                      showOrnot = !showOrnot;
                    });
                  },
                  icon: Icon(
                    showOrnot ? Icons.visibility : Icons.visibility_off,
                    size: 20,
                  ),
                )
              : null,
          filled: true,
          fillColor: const Color.fromARGB(255, 228, 228, 228),
          contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
            borderRadius: BorderRadius.circular(16.7),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
            borderRadius: BorderRadius.circular(16.7),
          ),
        ),
      ),
    );
  }
}
