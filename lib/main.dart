import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_auth_app/const/const_data.dart';
import 'package:supabase_auth_app/view/functionalui/login.dart';
import 'package:supabase_auth_app/view/welcomeui/welcome.dart';

void main() {
  GetIt locator = GetIt.instance;
  locator.registerSingleton<SupabaseClient>(
      SupabaseClient(
          URL,
          API));
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
        '/login':(_) => LoginScreen(),
        '/register':(_) => WelcomeScreen(),
        '/profile':(_) => WelcomeScreen(),

      },

    );
  }
}

