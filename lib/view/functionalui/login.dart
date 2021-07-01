import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart' hide Column;


class    LoginScreen extends StatefulWidget{
  const LoginScreen ({Key? key}) :super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState  extends State<LoginScreen>{
   final _nameController = TextEditingController();
   final _emailController = TextEditingController();
   final _passwordController = TextEditingController();

   final _formKey = GlobalKey<FormState>();

   Future _login() async {
     final sharedPreferences = await SharedPreferences.getInstance();

     final result = await GetIt.I.get<SupabaseClient>().auth.signIn(
         email: _emailController.text, password: _passwordController.text);

     if (result.data != null) {
       await sharedPreferences.setString(
           'user', result.data!.persistSessionString);
       Navigator.pushReplacementNamed(context, '/home');
     } else if (result.error?.message != null) {
       _showDialog(context, title: 'Error', message: result.error?.message);
     }
   }


  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: loginBody(context),
      backgroundColor: Colors.blueGrey,
   );
  }
  Widget loginBody(context){
    final sc_size= MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
              alignment: Alignment.center,
              child: Image.network('https://supabase.io/new/images/logo-dark.png',
              width: 300,)
            ),
            Container(
                alignment: Alignment.center,
                child: Image.network('https://events.flutter.dev/assets/img/logos/flutter-lockup.png',
                  width: 290,)
            ),
              SizedBox(height: 80,),
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
                                width: sc_size.width,
                                height: 45,
                                child: MaterialButton(
                                  onPressed: (){
                                    _login();
                                  },
                                  color: Colors.black,
                                  child: Text(
                                    'Login',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(height: 28,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Don\'t have an account ?'),
                                  SizedBox(width: 10,),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.pushNamed(context, '/register');
                                    },
                                    child: Text(
                                      'Create one!',
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
        ),
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

