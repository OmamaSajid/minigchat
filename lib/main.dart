import 'package:flutter/material.dart';
import 'package:flutter_application_7/chatscreen.dart';
import 'package:flutter_application_7/loginscreen.dart';
import 'package:flutter_application_7/registrationscreen.dart';
import 'package:flutter_application_7/welcomescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: welcomescreen.id,
      routes: {
        welcomescreen.id: (context) => welcomescreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen()
      },
    );
  }
}
