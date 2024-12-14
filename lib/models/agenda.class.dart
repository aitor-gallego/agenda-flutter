import 'dart:convert';

import 'package:agenda/models/contact.class.dart';
import 'package:agenda/models/app_state.enum.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Agenda extends ChangeNotifier {
  List<Contact> _contacts;
  List<Contact> _contactsAscending;
  List<Contact> _contactsDescending;

  bool? _isAscending;
  bool? get isAscending => _isAscending;
  set isAscending(bool? value) {
    _isAscending = value;
    notifyListeners();
  }

  List<Contact> get contactsFavorite =>
      contacts.where((e) => e.isFavorite).toList();

  AppState _state;
  AppState get state => _state;

  List<Contact> get contacts {
    switch (isAscending) {
      case null:
        return _contacts;
      case true:
        return _contactsAscending;
      case false:
        return _contactsDescending;
    }
  }

  Agenda({List<Contact>? contacts})
      : _contacts = contacts ?? [],
        _contactsAscending = List<Contact>.from(contacts ?? [])..sort(),
        _contactsDescending = List<Contact>.from(contacts ?? [])
          ..sort((a, b) => b.compareTo(a)),
        _state = AppState.initial;

  factory Agenda.fromJson(Map<String, dynamic> json) {
    return Agenda(
        contacts: json["contacts"] != null
            ? List.from(json["contacts"])
                .map((x) => Contact.fromJson(x))
                .toList()
            : []);
  }

  void notify() {
    notifyListeners();
  }

  void add(Contact value) {
    _contacts.add(value);
    _contactsAscending
      ..add(value)
      ..sort();
    _contactsDescending
      ..add(value)
      ..sort((a, b) => b.compareTo(a));
    notifyListeners();
  }

  void remove(Contact value) {
    _contacts.remove(value);
    _contactsAscending.remove(value);
    _contactsDescending.remove(value);
    notifyListeners();
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonStrign = jsonEncode(toJson());
    await prefs.setString("agendaData", jsonStrign);
  }

  Future<void> load() async {
    await Future.delayed(const Duration(seconds: 2));

    String? jsonString;
    final prefs = await SharedPreferences.getInstance();
    jsonString = prefs.getString("agendaData");

    if (jsonString != null) {
      _state = AppState.loaded;
      Map<String, dynamic> data = jsonDecode(jsonString);
      Agenda agenda = Agenda.fromJson(Map.from(data));
      _contacts = List.from(agenda._contacts);
      _contactsAscending = List.from(agenda._contactsAscending);
      _contactsDescending = List.from(agenda._contactsDescending);
      _isAscending = agenda._isAscending;
    } else {
      _state = AppState.initial;
    }
    notifyListeners();
    _state = AppState.ready;
  }

  Agenda copyWith({List<Contact>? contacts, bool? isAscending}) {
    return Agenda(
        contacts: contacts ??
            List.from(this.contacts.map((x) => x.copyWith()).toList()))
      ..isAscending = isAscending;
  }

  Map<String, dynamic> toJson() {
    return {
      if (_contacts.isNotEmpty)
        "contacts": _contacts.map((x) => x.toJson()).toList()
    };
  }

  @override
  String toString() {
    return "Agenda:\n Contacts: ${_contacts.map((e) => e.toString()).join("\n")}";
  }
}
