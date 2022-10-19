import 'package:chat_app/screens/auth_screen.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Firebase.initializeApp();
}

const primatyColor = Colors.pink;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: primatyColor,
            colorScheme: ColorScheme.fromSwatch(
              backgroundColor: primatyColor,
              accentColor: Colors.deepPurple,
              brightness: Brightness.dark,
            ),
            buttonTheme: ButtonTheme.of(context).copyWith(
                buttonColor: primatyColor,
                textTheme: ButtonTextTheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)))),
        home: AuthScreen());
  }
}
