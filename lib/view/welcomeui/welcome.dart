import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase/supabase.dart'as supa;

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MyWelcomeScreen();
  }

}

class MyWelcomeScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MyWelcomeScreenState();
  }
}

class _MyWelcomeScreenState  extends State<MyWelcomeScreen>{
  void checkLogin() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final session = sharedPreferences.getString('user');

    if (session == null) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      final response =
      await GetIt.instance<supa.SupabaseClient>().auth.recoverSession(session);

      sharedPreferences.setString('user', response.data!.persistSessionString);

      Navigator.pushReplacementNamed(context, '/profile');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //checkLogin();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedTextKit(animatedTexts: [
              TyperAnimatedText('Welcome to Supabase + Flutter authentification app',
               textStyle: const TextStyle(
                 fontSize: 32.0,
                 fontWeight: FontWeight.bold,
                 color: Colors.white
               ) ,
                textAlign: TextAlign.center,
                speed: const Duration(milliseconds: 300)
              )
            ],
            totalRepeatCount: 5,
            pause:  const Duration(milliseconds: 300),
            displayFullTextOnTap: true,
            stopPauseOnTap: true,
            ),

                SizedBox(height: 10,),

           ElevatedButton(

                style: ButtonStyle(
                enableFeedback: true,
                  overlayColor: MaterialStateProperty.all(Colors.greenAccent),
                ),
               onPressed: (){
                  print('clicked');
                 checkLogin();
               },
               child: Padding(
                 padding: new EdgeInsets.all(10.0),
                 child: new Text('Lets Go',
                   style: TextStyle(
                       color: Colors.white,
                       fontSize: 24,
                       fontWeight: FontWeight.bold

                   ),
                 ),
               )
           )
          ],
        ),
      ),
    );
  }
}