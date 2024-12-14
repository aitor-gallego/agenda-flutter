import 'package:age_calculator/age_calculator.dart';
import 'package:agenda/utils/capitalize.dart';
import 'package:flutter/material.dart';

class Contact extends ChangeNotifier implements Comparable<Contact> {
  int id;
  String? name;
  String? surname;
  String? email;
  String? phone;
  DateTime? birthdate;

  int? get age =>
      birthdate != null ? AgeCalculator.age(birthdate!).years : null;

  DateTime? _creation;
  DateTime? get creation => _creation;
  set creation(DateTime? value) {
    _creation = value;
    notifyListeners();
  }

  DateTime? _modification;
  DateTime? get modification => _modification;
  set modification(DateTime? value) {
    _modification = value;
    notifyListeners();
  }

  bool _isFavorite;
  bool get isFavorite => _isFavorite;
  set isFavorite(bool value) {
    _isFavorite = value;
    notifyListeners();
  }

  List<String> _labels;
  List<String> get labelsCapitalizes =>
      _labels.map((e) => capitalize(e)).toList();
  List<String> get labels => _labels;
  set labels(List<String> value) {
    _labels = value
        .map((e) => e.trim().toLowerCase())
        .where((e) => e != "")
        .toSet()
        .toList();
    notifyListeners();
  }

  Contact({
    required this.id,
    this.name,
    this.surname,
    this.email,
    this.phone,
    this.birthdate,
    DateTime? creation,
    DateTime? modification,
    bool isFavorite = false,
    List<String>? labels,
  })  : _creation = creation,
        _modification = modification,
        _isFavorite = isFavorite,
        _labels = labels != null ? List.from(labels) : [];

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
        id: json["id"] ?? 0,
        name: json["name"],
        surname: json["surname"],
        email: json["email"],
        phone: json["phone"],
        birthdate: DateTime.tryParse(json["birthdate"] ?? ""),
        creation: DateTime.tryParse(json["creation"] ?? ""),
        modification: DateTime.tryParse(json["modification"] ?? ""),
        isFavorite: json["isFavorite"] ?? false,
        labels: List.from(json["labels"] ?? []).cast<String>());
  }
  Contact copyWith({
    int? id,
    String? name,
    String? surname,
    String? email,
    String? phone,
    DateTime? birthdate,
    DateTime? creation,
    DateTime? modification,
    bool? isFavorite,
    List<String>? labels,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      birthdate: birthdate ?? this.birthdate,
      creation: creation ?? this.creation,
      modification: modification ?? this.modification,
      isFavorite: isFavorite ?? this.isFavorite,
      labels: labels ?? this.labels,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      if (name != null) "name": name,
      if (surname != null) "surname": surname,
      if (email != null) "email": email,
      if (phone != null) "phone": phone,
      if (birthdate != null) "birthdate": birthdate!.toIso8601String(),
      if (creation != null) "creation": creation!.toIso8601String(),
      if (modification != null) "modification": modification!.toIso8601String(),
      if (isFavorite) "isFavorite": true,
      if (labels.isNotEmpty) "labels": List.from(_labels),
    };
  }

  copyValuesFrom(Contact contact) {
    id = contact.id;
    name = contact.name;
    surname = contact.surname;
    email = contact.email;
    phone = contact.phone;
    birthdate = contact.birthdate;
    creation = contact.creation;
    modification = contact.modification;
    isFavorite = contact.isFavorite;
    labels = List.from(contact.labels);
    notifyListeners();
  }

  @override
  String toString() {
    return "Contacto:\n ${[
      "ID: $id",
      if (name != null) "Name: $name",
      if (surname != null) "Surname: $surname",
      if (email != null) "Email: $email",
      if (phone != null) "Phone: $phone",
      if (birthdate != null) "Birthdate: $birthdate",
      if (creation != null) "Creation: $creation",
      if (modification != null) "Modification: $modification",
      if (isFavorite) "Is Favorite",
      if (labels.isNotEmpty) "Labels: ${labels.join(",")}",
    ].map((e) => "\t$e").join("\n")}";
  }

  /// compara el nombre, si son iguales compara el apellido
  @override
  int compareTo(other) {
    int nameComparison = (name ?? "~").compareTo(other.name ?? "~");
    if (nameComparison != 0) return nameComparison;
    return (surname ?? "~").compareTo(other.surname ?? "~");
  }

  bool equalsData(Object other) {
    if (other is Contact) {
      return name == other.name &&
          surname == other.surname &&
          email == other.email &&
          phone == other.phone &&
          birthdate == other.birthdate;
    }
    return false;
  }
}
