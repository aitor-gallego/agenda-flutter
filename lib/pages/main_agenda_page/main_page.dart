import 'package:agenda/pages/main_agenda_page/list_contacts_page.dart';
import 'package:agenda/models/events_hub.dart';
import 'package:agenda/models/agenda.class.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  Widget _body(BuildContext context) {
    Agenda agenda = Provider.of<Agenda>(context);
    if (agenda.contacts.isNotEmpty) {
      return TabBarView(children: [
        ListViewContacts(
          contacts: agenda.contacts,
        ),
        ListViewContacts(
          contacts: agenda.contactsFavorite,
        )
      ]);
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 40),
        child: Text(
          "Agenda Vacia. \nToca '+' para añadir un contacto.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[600], fontSize: 40),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Agenda agenda = Provider.of<Agenda>(context);
    EventsHub event = Provider.of<EventsHub>(context, listen: false);

    return SafeArea(
        child: DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Agenda"),
          actions: [
            IconButton(
                onPressed: () {
                  event.onSort(context);
                },
                icon: Icon(agenda.isAscending ?? true
                    ? FontAwesomeIcons.arrowDownAZ
                    : FontAwesomeIcons.arrowDownZA)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list)),
          ],
        ),
        body: _body(context),
        bottomNavigationBar: Container(
          color: Colors.grey[900],
          child: const TabBar(tabs: [
            Tab(icon: Icon(Icons.account_box), text: "Contactos"),
            Tab(icon: Icon(Icons.star), text: "Favoritos")
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            event.onCreateContact(context);
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    ));
  }
}
