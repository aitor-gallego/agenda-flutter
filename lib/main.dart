import 'package:agenda/firebase_options.dart';
import 'package:agenda/models/events_hub.dart';
import 'package:agenda/models/agenda.class.dart';
import 'package:agenda/pages/login_page/login_page.dart';
import 'package:agenda/services/auth_service.dart';
import 'package:agenda/services/eventshub_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Agenda>(create: (context) => Agenda()),
        Provider<EventsHub>(create: (context) => EventsHub()),
        Provider<EventsHubSrv>(create: (context) => EventsHubSrv()),
        Provider<AuthSrv>(create: (context) => AuthSrv())
      ],
      child: MaterialApp(
        title: 'Agenda',
        theme: ThemeData.dark(
          useMaterial3: true,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
