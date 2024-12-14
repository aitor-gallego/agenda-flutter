import 'package:flutter/material.dart';

Future<String?> bottomSheetLabelss(BuildContext context, String labels) {
  return showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 120,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  initialValue: labels,
                  onChanged: (value) => labels = value,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(labels);
                  },
                  child: const Text("Aplicar"))
            ],
          ),
        );
      });
}
