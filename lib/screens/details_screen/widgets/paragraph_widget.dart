import 'package:flutter/material.dart';

class ParagraphWidget extends StatelessWidget {
  final String text;

  const ParagraphWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16.0),
      ),
    );
  }
}