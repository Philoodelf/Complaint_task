import 'package:flutter/material.dart';

class Mytextfield extends StatelessWidget {
  final controller;
  final String variable;
  final TextInputType keyboardType;

  const Mytextfield({
    super.key,
    this.controller,
    required this.variable,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          labelText: variable,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.black),
          ),
          fillColor: const Color.fromARGB(150, 238, 238, 238),
          filled: true,
        ),
      ),
    );
  }
}
