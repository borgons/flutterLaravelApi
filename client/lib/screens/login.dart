import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/api_response.dart';
import '../models/user.dart';
import '../services/user_service.dart';

import '../constant.dart';
import './home.dart';
import './register.dart';

class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool loading = false;
  
  void _loginUser() async {
    ApiResponse response = await login(txtEmail.text, txtPassword.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')
      ));
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> Home()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(32),
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress, 
              controller: txtEmail, 
              validator: (val) => val!.isEmpty ? 'Invalid email address' : null,
              decoration: kInputDecoration('Email')
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: txtPassword, 
              obscureText: true,
              validator: (val) => val!.length < 6 ? 'Required at least 6 chars' : null,
              decoration: kInputDecoration('Password')
            ),
            SizedBox(height: 10),
            loading ? Center(child: CircularProgressIndicator())
            : kTextButton('Login', () {
              if(formKey.currentState!.validate()){
                setState(() {
                  loading = true;
                  _loginUser();
                });
              }
            }),
            SizedBox(height: 10),
            kLoginRegisterHint('Dont have an account?', 'Register', (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Register()),  (route) => false);
            })
          ],
        ),
      ),
    );
  }
}