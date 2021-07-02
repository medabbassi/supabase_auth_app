import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase/supabase.dart' as supa;

class RegisterScreen extends StatefulWidget{
  const RegisterScreen ({Key? key }): super(key:  key);
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen>{
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future _register() async {
    final result = await GetIt.instance<supa.SupabaseClient>()
        .auth
        .signUp(_emailController.text, _passwordController.text);

    if (result.data != null) {
      Navigator.pushReplacementNamed(context, '/login');
      _showDialog(context, title: 'Success', message: 'Register Successful');
    } else if (result.error?.message != null) {
      _showDialog(context, title: 'Error', message: result.error?.message);
    }

    setState(() {
      // just for simplicity reasons (clean the textfields)
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterBody(context),
      backgroundColor: Colors.blueGrey,
    );
  }
  // ignore: non_constant_identifier_names
  Widget RegisterBody(context){
    final scSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
                alignment: Alignment.center,
                child: Image.network('https://supabase.io/new/images/logo-dark.png',
                  width: 250,)
            ),
            Container(
                alignment: Alignment.center,
                child: Image.network('https://events.flutter.dev/assets/img/logos/flutter-lockup.png',
                  width: 250,)
            ),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Card(
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.only(bottom: 40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox( height: 10),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            controller: _nameController,
                            cursorColor: Colors.black,
                            style: TextStyle(),
                            decoration: InputDecoration(
                              labelText: 'Your name',
                              labelStyle: TextStyle(color: Colors.black),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: new BorderSide(color: Colors.black)
                              ),
                            ),
                            validator: (String? value){
                              if (value!.isEmpty) {
                                return 'You must enter your name';
                              }
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            controller: _emailController,
                            cursorColor: Colors.black,
                            style: TextStyle(),
                            decoration: InputDecoration(
                              labelText: 'E-mail',
                              labelStyle: TextStyle(color: Colors.black),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: new BorderSide(color: Colors.black)
                              ),
                            ),
                            validator: (String? value){
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Invalid e-mail';
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            controller: _passwordController,
                            cursorColor: Colors.black,
                            obscureText: true,
                            style: TextStyle(),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.black),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: new BorderSide(color: Colors.black),
                              ),
                            ),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Invalid password';
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          width: scSize.width,
                          height: 45,
                          child: MaterialButton(
                            onPressed: (){
                              _register();
                            },
                            color: Colors.black,
                            child: Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: 28,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('You already have one !'),
                            SizedBox(width: 10,),
                            GestureDetector(
                              onTap: (){
                                Navigator.pushNamed(context, '/login');
                              },
                              child: Text(
                                'Come Here!',
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.greenAccent),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}
void _showDialog(context, {String? title, String? message}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text(title ?? ''),
        content: new Text(message ?? ''),
        actions: <Widget>[
          new MaterialButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

