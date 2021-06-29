import 'package:flutter/material.dart';
import 'package:supabase_auth_app/view/welcomeui/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A supabase auth test app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      initialRoute: '/',
      routes: {
        '/':(_) => WelcomeScreen(),
        '/login':(_) => WelcomeScreen(),
        '/register':(_) => WelcomeScreen(),
        '/profile':(_) => WelcomeScreen(),

      },

    );
  }
}

