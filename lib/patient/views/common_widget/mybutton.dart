import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;

  const MyButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 2, left: 5),
      child: TextButton(
        onPressed: () {},
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.orange, width: 2),
          ),
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
            child: Text(text, style: const TextStyle(color: Colors.orange),),
          ),
        ),
      ),
    );
  }
}
