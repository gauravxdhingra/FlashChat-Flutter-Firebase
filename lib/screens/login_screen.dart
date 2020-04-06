import 'package:flash_chat/components/input_field.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            InputField(
              hinttextlabel: 'Enter your email',
              onpressed: (value) {
                email = value;
              },
              obscuretext: false,
              kbtp: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 8.0,
            ),
            InputField(
              hinttextlabel: 'Enter your password',
              onpressed: (value) {
                password = value;
              },
              obscuretext: true,
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              onPressed: () async {
                //Implement login functionality.
                try {
                  final newUser = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (newUser != null)
                    Navigator.pushNamed(context, ChatScreen.routeName);
                } catch (e) {
                  print(e);
                }
              },
              title: 'Login',
              color: Colors.lightBlueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
