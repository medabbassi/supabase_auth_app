
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {

   return Scaffold(
      body: _LoginBody(context),
      backgroundColor: Colors.greenAccent,
   );
  }
  Widget _LoginBody(context){
    final sc_size= MediaQuery.of(context).size;
    return SingleChildScrollView(

    );
  }

}