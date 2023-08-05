import 'package:flutter/material.dart';

class MarkItem extends StatelessWidget {
  const MarkItem({super.key, required this.color, required this.text});

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(52),
          color: color,
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(text),
        ),
      ),
    );
  }
}
