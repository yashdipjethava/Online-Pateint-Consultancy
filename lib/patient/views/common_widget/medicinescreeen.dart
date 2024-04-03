import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget bannerWidget(Size size, {required String text, required IconData icon}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: size.width * 0.025),
    child: Container(
      height: size.height * 0.055,
      width: size.width * 0.45,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
        child: Row(
          children: [
            FaIcon(icon, color: Colors.teal,size: 20,),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.teal,
                ),
                overflow: TextOverflow.visible,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
