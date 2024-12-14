import 'package:agenda/modals/alert_dialg.dart';
import 'package:agenda/models/contact.class.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ContactFormPage extends StatefulWidget {
  final Contact contact;
  final String title;
  const ContactFormPage({
    super.key,
    required this.contact,
    required this.title,
  });

  @override
  State<ContactFormPage> createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _name, _surname, _phone, _email, _birthdateFormat;
  DateTime? _birthdata;
  bool isChange = false;
  late Contact initialContact;
  late Contact contact;
  @override
  void initState() {
    initialContact = widget.contact;
    contact = initialContact.copyWith();
    _name = TextEditingController(text: initialContact.name);
    _surname = TextEditingController(text: initialContact.surname);
    _phone = TextEditingController(text: initialContact.phone);
    _email = TextEditingController(text: initialContact.email);
    _birthdateFormat = TextEditingController(
        text: initialContact.birthdate != null
            ? DateFormat.yMMMd().format(initialContact.birthdate!)
            : "");
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _surname.dispose();
    _phone.dispose();
    _email.dispose();
    _birthdateFormat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (initialContact == contact) {
          return true;
        }
        bool? result = await alertDialogConfirmationExit(context);
        return result ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
                onPressed: isChange ? onSubmitForm : null,
                icon: const Icon(Icons.check))
          ],
        ),
        body: Container(
          margin: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(
                      labelText: "Nombre", hintText: "Nombre"),
                  onChanged: (value) {
                    onChange();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _surname,
                  decoration: const InputDecoration(
                      labelText: "Apellidos", hintText: "Apellidos"),
                  onChanged: (value) {
                    onChange();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _phone,
                  decoration: const InputDecoration(
                      labelText: "Teléfono", hintText: "Teléfono"),
                  onChanged: (value) {
                    onChange();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(
                      labelText: "Email", hintText: "Email"),
                  validator: validateEmail,
                  onChanged: (value) {
                    onChange();
                  },
                ),
                TextFormField(
                  readOnly: true,
                  controller: _birthdateFormat,
                  decoration:
                      const InputDecoration(labelText: "Fecha de nacimiento"),
                  onTap: () async {
                    DateTime? datetime = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now()
                            .copyWith(year: DateTime.now().year - 150),
                        lastDate: DateTime.now());
                    if (datetime != null) {
                      _birthdateFormat.text =
                          DateFormat.yMMMd().format(datetime);
                      _birthdata = datetime;
                    }
                    onChange();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validateEmail(value) {
    if (value == "" || value == null) {
      return null;
    }
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.'
        r'[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return "Formato de email incorrecto";
    }
    return null;
  }

  void onSubmitForm() {
    if (_formKey.currentState!.validate()) {
      initialContact.copyValuesFrom(contact);
      Navigator.of(context).pop(true);
    }
  }

  void onChange() {
    contact.name = _name.text.isEmpty ? null : _name.text;
    contact.surname = _surname.text.isEmpty ? null : _surname.text;
    contact.phone = _phone.text.isEmpty ? null : _phone.text;
    contact.email = _email.text.isEmpty ? null : _email.text;
    contact.birthdate = _birthdata;

    setState(() {
      if (!initialContact.equalsData(contact)) {
        isChange = true;
      } else {
        isChange = false;
      }
    });
  }
}
