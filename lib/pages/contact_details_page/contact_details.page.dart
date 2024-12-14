// ignore_for_file: avoid_print

import 'package:agenda/models/events_hub.dart';
import 'package:agenda/modals/snack_bar.dart';
import 'package:agenda/models/contact.class.dart';
import 'package:agenda/utils/icons.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ContactDetailsPage extends StatefulWidget {
  const ContactDetailsPage({super.key, required this.contact});
  final Contact contact;
  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  @override
  Widget build(BuildContext context) {
    EventsHub event = Provider.of<EventsHub>(context, listen: false);
    Contact contact = widget.contact;
    ThemeData theme = Theme.of(context);

    return ListenableBuilder(
        listenable: contact,
        builder: (context, child) {
          return SafeArea(
              child: Scaffold(
                  appBar: AppBar(
                    actions: [
                      IconButton(
                        onPressed: () {
                          event.onEditFavorite(context, contact);
                          print("contact.isFavorite: ${contact.isFavorite}");
                        },
                        icon: Icon(contact.isFavorite
                            ? Icons.star
                            : Icons.star_border_outlined),
                      ),
                      IconButton(
                        onPressed: () {
                          event.onEditContact(context, contact);
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                              width: 200,
                              height: 200,
                              decoration: const BoxDecoration(
                                  color: Colors.black, shape: BoxShape.circle),
                              child: Icon(
                                icons(contact.labels.isEmpty
                                    ? ""
                                    : contact.labels[0]),
                                size: 150,
                              )),
                          const SizedBox(height: 20),
                          Text(
                            [
                              if (contact.name != null) contact.name,
                              if (contact.surname != null) contact.surname,
                            ].join(" "),
                            style: theme.textTheme.headlineLarge,
                          ),
                          const Divider(),
                          ListTile(
                            title: const Text("Correo electrónico"),
                            subtitle: Text(
                              contact.email ?? "",
                              style: theme.textTheme.headlineSmall,
                            ),
                            trailing: const Icon(Icons.email),
                            onTap: () {
                              if (contact.email != null) {
                                snackBar(context,
                                    "Enviando email a ${contact.email}");
                              }
                            },
                          ),
                          const Divider(),
                          ListTile(
                            title: const Text("Teléfono"),
                            subtitle: Text(
                              contact.phone ?? "",
                              style: theme.textTheme.headlineSmall,
                            ),
                            trailing: const Icon(Icons.phone),
                            onTap: () {
                              if (contact.phone != null) {
                                snackBar(
                                    context,
                                    "Llamando a ${[
                                      if (contact.name != null) contact.name,
                                      if (contact.surname != null)
                                        contact.surname,
                                    ].join(" ")}");
                              }
                            },
                          ),
                          const Divider(),
                          Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: const Text("Nacimiento"),
                                  subtitle: Text(
                                    contact.birthdate != null
                                        ? DateFormat.yMMMd()
                                            .format(contact.birthdate!)
                                        : "",
                                    style: theme.textTheme.headlineSmall,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: const Text("Edad"),
                                  subtitle: Text(
                                    contact.age != null
                                        ? contact.age.toString()
                                        : "",
                                    style: theme.textTheme.headlineSmall,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          ListTile(
                            title: const Text("Etiquetas"),
                            subtitle: Text(
                              contact.labels.isEmpty
                                  ? "No asignadas"
                                  : contact.labelsCapitalizes.join(","),
                              style: theme.textTheme.headlineSmall,
                            ),
                            onTap: () async {
                              event.onEditLabels(context, contact,
                                  saveChanges: true);
                            },
                          ),
                          const Divider(),
                          if (contact.creation != null)
                            Text(
                                "Added on ${DateFormat("yyyy-MM-dd HH:mm:ss").format(contact.creation!)}"),
                          if (contact.modification != null)
                            Text(
                                "Modiffied on ${DateFormat("yyyy-MM-dd HH:mm:ss").format(contact.modification!)}")
                        ],
                      ),
                    ),
                  )));
        });
  }
}
