import 'package:agenda/pages/main_agenda_page/main_page.dart';
import 'package:agenda/models/agenda.class.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BootPage extends StatefulWidget {
  const BootPage({super.key});

  @override
  State<BootPage> createState() => _BootPageState();
}

class _BootPageState extends State<BootPage> {
  @override
  void initState() {
    NavigatorState navigator = Navigator.of(context);
    Agenda agenda = Provider.of<Agenda>(context, listen: false);
    agenda.load().then((value) {
      navigator.pushReplacement(
          MaterialPageRoute(builder: (context) => const ContactsPage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text("Cargando los datos...")
          ],
        ),
      ),
    );
  }
}
