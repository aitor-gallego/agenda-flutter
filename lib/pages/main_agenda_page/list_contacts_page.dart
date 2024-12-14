import 'package:agenda/models/events_hub.dart';
import 'package:agenda/models/contact.class.dart';
import 'package:agenda/utils/icons.dart';
import 'package:agenda/view_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListViewContacts extends StatefulWidget {
  const ListViewContacts({super.key, required this.contacts});
  final List<Contact> contacts;
  @override
  State<ListViewContacts> createState() => _ListViewContactsState();
}

class _ListViewContactsState extends State<ListViewContacts> {
  @override
  Widget build(BuildContext context) {
    EventsHub event = Provider.of<EventsHub>(context, listen: false);
    List<Contact> listContac = widget.contacts;
    return ListView.builder(
      itemCount: listContac.length,
      itemBuilder: (context, index) {
        Contact contact = listContac[index];
        return ListenableBuilder(
            listenable: contact,
            builder: (context, child) {
              return ListTile(
                onTap: () {
                  viewContactDetails(context, contact);
                },
                leading: Icon(
                    icons(contact.labels.isEmpty ? "" : contact.labels[0])),
                title: Row(
                  children: [
                    Text([
                      if (contact.name != null) contact.name,
                      if (contact.surname != null) contact.surname,
                    ].join(" ")),
                    if (contact.isFavorite)
                      const Icon(
                        Icons.star,
                        size: 15,
                      )
                  ],
                ),
                subtitle: Text([
                  if (contact.email != null) "${contact.email}",
                  if (contact.phone != null) "${contact.phone}",
                ].join(", ")),
                trailing: PopupMenuButton<int>(
                  onSelected: (int result) {
                    if (result == 1) {
                      viewContactDetails(context, contact);
                    } else if (result == 2) {
                      event.onEditContact(context, contact);
                    } else if (result == 3) {
                      event.onDeleteContact(context, contact);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                        value: 1,
                        child: Row(
                          children: [
                            Icon(Icons.remove_red_eye),
                            SizedBox(width: 10),
                            Text("Ver")
                          ],
                        )),
                    const PopupMenuItem(
                        value: 2,
                        child: Row(
                          children: [
                            Icon(Icons.edit),
                            SizedBox(width: 10),
                            Text("Editar")
                          ],
                        )),
                    const PopupMenuItem(
                        value: 3,
                        child: Row(
                          children: [
                            Icon(Icons.delete),
                            SizedBox(width: 10),
                            Text("Eliminar")
                          ],
                        )),
                  ],
                  icon: const Icon(Icons.more_vert),
                ),
              );
            });
      },
    );
  }
}
