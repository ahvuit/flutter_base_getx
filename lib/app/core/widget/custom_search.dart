import 'package:flutter/material.dart';

class CustomSearch extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hintText;

  const CustomSearch({super.key, required this.onChanged, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14),
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}