import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                  Navigator.pushReplacementNamed(context, '/login');
               },
               child: Padding(
                 padding: new EdgeInsets.all(10.0),
                 child: new Text('Start',
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