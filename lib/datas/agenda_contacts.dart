import 'package:agenda/models/agenda_class.dart';
import 'package:agenda/models/contact_class.dart';

var agenda = AgendaData(contacts: [
  Contact(id: 1, name: "Alice", surname: "Johnson", email: "alice.j@example.com", phone: "555-0001", birthdate: DateTime(1990, 1, 5), isFavorite: true, labels: ["Trabajo"]),
  Contact(id: 2, name: "Bob", surname: "Smith", email: "bob.s@example.com", phone: "555-0002", birthdate: DateTime(1985, 2, 15), labels: ["Trabajo"]),
  Contact(id: 3, name: "Charlie", surname: "Brown", email: "charlie.b@example.com", phone: "555-0003", birthdate: DateTime(1975, 3, 25), isFavorite: true, labels: ["Trabajo"]),
  Contact(id: 4, name: "Diana", surname: "Evans", email: "diana.e@example.com", phone: "555-0004", birthdate: DateTime(2000, 4, 5), labels: ["Trabajo"]),
  Contact(id: 5, name: "Edward", surname: "Green", email: "edward.g@example.com", phone: "555-0005", birthdate: DateTime(1995, 5, 15), isFavorite: false, labels: ["Clase"]),
  Contact(id: 6, name: "Fiona", surname: "Harris", email: "fiona.h@example.com", phone: "555-0006", birthdate: DateTime(1988, 6, 5), labels: ["Clase"]),
  Contact(id: 7, name: "George", surname: "King", email: "george.k@example.com", phone: "555-0007", birthdate: DateTime(1983, 7, 25), isFavorite: true, labels: ["Clase"]),
  Contact(id: 8, name: "Holly", surname: "Lane", email: "holly.l@example.com", phone: "555-0008", birthdate: DateTime(1992, 8, 15), labels: ["Clase"]),
  Contact(id: 9, name: "Ian", surname: "Mills", email: "ian.m@example.com", phone: "555-0009", birthdate: DateTime(1999, 9, 5), isFavorite: false, labels: ["Clase"]),
  Contact(id: 10, name: "Jackie", surname: "Norris", email: "jackie.n@example.com", phone: "555-0010", birthdate: DateTime(1979, 10, 15), labels: ["Gym"]),
  Contact(id: 11, name: "Karen", surname: "Owens", email: "karen.o@example.com", phone: "555-0011", birthdate: DateTime(1993, 11, 5), isFavorite: true, labels: ["Gym"]),
  Contact(id: 12, name: "Liam", surname: "Parker", email: "liam.p@example.com", phone: "555-0012", birthdate: DateTime(1981, 12, 15), labels: ["Gym"]),
  Contact(id: 13, name: "Megan", surname: "Quinn", email: "megan.q@example.com", phone: "555-0013", birthdate: DateTime(1987, 1, 25), isFavorite: false, labels: ["Gym"]),
  Contact(id: 14, name: "Nina", surname: "Reed", email: "nina.r@example.com", phone: "555-0014", birthdate: DateTime(1976, 2, 5), labels: ["Gym"]),
  Contact(id: 15, name: "Oliver", surname: "Scott", email: "oliver.s@example.com", phone: "555-0015", birthdate: DateTime(1982, 3, 15), isFavorite: true, labels: ["Trabajo"]),
  Contact(id: 16, name: "Paula", surname: "Taylor", email: "paula.t@example.com", phone: "555-0016", birthdate: DateTime(1984, 4, 25), labels: ["Clase"]),
  Contact(id: 17, name: "Quincy", surname: "Upton", email: "quincy.u@example.com", phone: "555-0017", birthdate: DateTime(1998, 5, 5), isFavorite: false, labels: ["Gym"]),
  Contact(id: 18, name: "Rachel", surname: "Vance", email: "rachel.v@example.com", phone: "555-0018", birthdate: DateTime(1996, 6, 15), labels: ["Trabajo"]),
  Contact(id: 19, name: "Samuel", surname: "Walker", email: "samuel.w@example.com", phone: "555-0019", birthdate: DateTime(1991, 7, 5), isFavorite: true, labels: ["Clase"]),
  Contact(id: 20, name: "Tina", surname: "Xavier", email: "tina.x@example.com", phone: "555-0020", birthdate: DateTime(1994, 8, 15), labels: ["Trabajo"]),
]);
