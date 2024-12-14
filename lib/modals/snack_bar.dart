import 'package:flutter/material.dart';

void snackBar(BuildContext context, String value) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(value),
      duration: const Duration(seconds: 2),
    ),
  );
}
