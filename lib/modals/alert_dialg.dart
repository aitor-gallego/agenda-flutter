import 'package:flutter/material.dart';

Future<bool?> alertDialogConfirmationExit(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Aviso"),
        content:
            const Text("¿Seguro que deseas salir? Los cambios no se guardarán"),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text("No"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text("Sí"),
          ),
        ],
      );
    },
  );
}

Future<bool?> alertDialogConfirmationDelete(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Aviso"),
        content:
            const Text("Esta apunto de borrar un contacto. ¿Estás seguro?"),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text("Aceptar"),
          ),
        ],
      );
    },
  );
}
