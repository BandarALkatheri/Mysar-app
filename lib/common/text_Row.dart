import 'package:flutter/material.dart';

class row_text extends StatelessWidget {
  row_text(
      {super.key,
      this.showall = true,
      required this.textone,
      required this.texttwo,
      required this.onTap});
  final textone;
  final texttwo;
  void Function()? onTap;
  final bool showall;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        showall
            ? Container(
                margin: const EdgeInsets.all(8),
                height: 30,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromARGB(255, 243, 243, 243)),
                child: Center(
                  child: GestureDetector(
                    onTap: onTap,
                    child: Text(
                      'اظهار الكل',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              )
            : Text(''),
        const Spacer(
          flex: 2,
        ),
        Text(
          textone.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Helvetica',
            fontSize: 18,
            color: Colors.orange,
          ),
        ),
        Text(
          texttwo.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Helvetica',
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
