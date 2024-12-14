// ignore_for_file: use_build_context_synchronously

import 'package:agenda/modals/alert_dialg.dart';
import 'package:agenda/modals/boottom_sheet.dart';
import 'package:agenda/modals/snack_bar.dart';
import 'package:agenda/models/agenda.class.dart';
import 'package:agenda/models/contact.class.dart';
import 'package:agenda/view_page.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventsHub {
  onCreateContact(BuildContext context) async {
    onEditContact(context, Contact(id: 0), isNew: true);
  }

  onEditContact(BuildContext context, Contact contactData,
      {bool isNew = false}) async {
    Agenda agenda = Provider.of<Agenda>(context, listen: false);
    Contact contact = contactData.copyWith();
    String title = "";
    if (isNew) {
      title = "Nuevo contacto";
      contact.creation = DateTime.now();
    } else {
      title = "Edición de una contacto";
      contact.modification = DateTime.now();
    }
    bool? guardado = await viewContactForm(context, contact, title);
    if (guardado ?? false) {
      if (isNew) {
        agenda.add(contact);
      } else {
        contactData.copyValuesFrom(contact);
      }
      onSaveAgenda(context);
    }
  }

  onSaveAgenda(BuildContext context) {
    Agenda agenda = Provider.of<Agenda>(context, listen: false);
    agenda.save().then((value) {
      snackBar(context, "Los cambios se han guardado.");
    }).onError(
      (error, stackTrace) {
        snackBar(
            context, "Se ha producido un error al guardar los cambios.");
      },
    );
  }

  onDeleteContact(BuildContext context, Contact contactData) async {
    Agenda agenda = Provider.of<Agenda>(context, listen: false);
    bool? result = await alertDialogConfirmationDelete(context);
    if (result ?? false) {
      agenda.remove(contactData);
      agenda.save();
    }
  }

  onEditLabels(BuildContext context, Contact contact,
      {bool saveChanges = false}) async {
    String? label =
        await bottomSheetLabelss(context, contact.labelsCapitalizes.join(","));
    if (saveChanges && label != null) {
      contact.labels = removeDiacritics(label).split(",").toList();
      onSaveAgenda(context);
    }
  }

  onEditFavorite(BuildContext context, Contact contact) {
    Agenda agenda = Provider.of<Agenda>(context, listen: false);
    contact.isFavorite = !contact.isFavorite;
    agenda.notify();
    onSaveAgenda(context);
  }

  onSort(BuildContext context) {
    Agenda agenda = Provider.of<Agenda>(context, listen: false);
    agenda.isAscending = !(agenda.isAscending ?? false);
  }
}
