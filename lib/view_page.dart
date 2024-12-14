import 'package:agenda/pages/contact_details_page/contact_details.page.dart';
import 'package:agenda/pages/contact_form_page/contact_form_page.dart';
import 'package:agenda/models/contact.class.dart';
import 'package:flutter/material.dart';

void viewContactDetails(BuildContext context, Contact contact) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ContactDetailsPage(contact: contact)));
}

Future<bool?> viewContactForm(
    BuildContext context, Contact contact, String title) {
  return Navigator.of(context).push<bool>(MaterialPageRoute(
      builder: (context) => ContactFormPage(contact: contact, title: title)));
}
