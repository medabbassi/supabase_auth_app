import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase/supabase.dart' as supa;

class ProfileScreen extends StatefulWidget{
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState  extends State<ProfileScreen>{
  @override
  Widget build (BuildContext context){
    final currentUser = GetIt.instance<supa.SupabaseClient>().auth.user();
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Hi ${currentUser?.email}'),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                color: Colors.red,
                onPressed: () {
                  _logout();
                },
                child: Text('Logout'),
              )
            ],
          ),
        ),
      ),
      );
    }
  _logout() async {
    await GetIt.I.get<supa.SupabaseClient>().auth.signOut();

    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();

    Navigator.pushReplacementNamed(context, '/');
  }
}
